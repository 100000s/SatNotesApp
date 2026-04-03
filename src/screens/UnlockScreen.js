import React, { useState, useRef, useEffect } from "react";
import { View, StyleSheet, PanResponder, Alert, Text } from "react-native";
import Svg, { Line } from "react-native-svg";
import * as Haptics from "expo-haptics";
import Animated, {
  useSharedValue,
  useAnimatedStyle,
  withTiming,
} from "react-native-reanimated";
import * as SecureStore from "expo-secure-store";
import * as LocalAuthentication from "expo-local-authentication";

/* ================= TEXT ================= */
const TEXT = {
  en: {
    instructions: "Draw your unlock pattern to get started",
    incorrect: "Incorrect pattern",
    tryAgain: "Try once more",
    locked: "Locked",
    lockedMsg: "Too many failed attempts. Try again in 10 minutes.",
    saved: "Pattern saved!",
    savedMsg: "Your pattern has been saved!",
    tryLater: "Try again later.",
    language: "Español",
    biometric: "Use fingerprint",
    biometricUnavailable: "Biometrics not available",
  },
  es: {
    instructions: "Dibuja tu patrón de desbloqueo para comenzar",
    incorrect: "Patrón incorrecto",
    tryAgain: "Inténtalo otra vez",
    locked: "Bloqueado",
    lockedMsg: "Demasiados intentos fallidos. Intenta en 10 minutos.",
    saved: "¡Patrón guardado!",
    savedMsg: "Tu patrón ha sido guardado.",
    tryLater: "Intenta más tarde.",
    language: "English",
    biometric: "Usar huella digital",
    biometricUnavailable: "Biometría no disponible",
  },
};

const FLUOR_COLOR = "#00FFC6";
const ORANGE_COLOR = "#FFA500";

/* ================= DOT ================= */
const Dot = ({ isSelected }) => {
  const glow = useSharedValue(0.3);

  useEffect(() => {
    glow.value = withTiming(isSelected ? 1 : 0.3, { duration: 100 });
  }, [isSelected]);

  const animatedStyle = useAnimatedStyle(() => ({
    transform: [{ scale: 1 + glow.value * 0.4 }],
    opacity: 0.7 + glow.value * 0.6,
  }));

  return <Animated.View style={[styles.dot, animatedStyle]} />;
};

/* ================= SCREEN ================= */
export default function UnlockScreen({ onUnlock, language, toggleLanguage }) {
  const [selected, setSelected] = useState([]);
  const selectedRef = useRef([]);
  const [isFirstTime, setIsFirstTime] = useState(false);
  const [lockedUntil, setLockedUntil] = useState(null);

  const attemptsRef = useRef(0);

  const t = TEXT[language];
  const dotRefs = useRef({});

  const dots = [
    { id: 0, x: 80, y: 40 },
    { id: 1, x: 160, y: 40 },
    { id: 2, x: 40, y: 110 },
    { id: 3, x: 120, y: 110 },
    { id: 4, x: 200, y: 110 },
    { id: 5, x: 80, y: 180 },
    { id: 6, x: 160, y: 180 },
  ];

  /* ================= INIT ================= */
  useEffect(() => {
    const load = async () => {
      const stored = await SecureStore.getItemAsync("userPattern");
      const lockTime = await SecureStore.getItemAsync("lockUntil");

      if (!stored) setIsFirstTime(true);
      if (lockTime) setLockedUntil(parseInt(lockTime));
    };

    load();
  }, []);

  /* ================= LOCK ================= */
  const isLocked = () => {
    if (!lockedUntil) return false;
    return Date.now() < lockedUntil;
  };

  const triggerLockout = async () => {
    const lockTime = Date.now() + 10 * 60 * 1000;
    await SecureStore.setItemAsync("lockUntil", lockTime.toString());
    setLockedUntil(lockTime);
    Alert.alert(t.locked, t.lockedMsg);
  };

  /* ================= BIOMETRIC ================= */
  const tryBiometric = async () => {
    if (isLocked()) {
      Alert.alert(t.locked, t.tryLater);
      return;
    }

    const hasHardware = await LocalAuthentication.hasHardwareAsync();
    const enrolled = await LocalAuthentication.isEnrolledAsync();

    if (!hasHardware || !enrolled) {
      Alert.alert(t.biometricUnavailable);
      return;
    }

    const result = await LocalAuthentication.authenticateAsync({
      promptMessage: t.biometric,
    });

    if (result.success) {
      attemptsRef.current = 0;
      onUnlock();
    } else {
      triggerLockout();
    }
  };

  /* ================= TOUCH ================= */
  const getTouchedDot = (pageX, pageY) => {
    dots.forEach((dot) => {
      const ref = dotRefs.current[dot.id];
      if (!ref || !ref.measure) return;

      ref.measure((fx, fy, width, height, px, py) => {
        const centerX = px + width / 2;
        const centerY = py + height / 2;

        const dx = pageX - centerX;
        const dy = pageY - centerY;

        if (Math.sqrt(dx * dx + dy * dy) < width / 2) {
          setSelected((prev) => {
            if (!prev.includes(dot.id)) {
              const updated = [...prev, dot.id];
              selectedRef.current = updated;
              return updated;
            }
            return prev;
          });
        }
      });
    });
  };

  /* ================= GESTURE ================= */
  const panResponder = useRef(
    PanResponder.create({
      onStartShouldSetPanResponder: () => true,

      onPanResponderMove: (evt) => {
        const { pageX, pageY } = evt.nativeEvent;
        getTouchedDot(pageX, pageY);
      },

      onPanResponderRelease: async () => {
        if (isLocked()) {
          Alert.alert(t.locked, t.lockedMsg);
          setSelected([]);
          selectedRef.current = [];
          return;
        }

        const pattern = selectedRef.current;
        const currentHash = pattern.join("-");

        if (pattern.length >= 4) {
          const storedPattern = await SecureStore.getItemAsync("userPattern");

          if (!storedPattern) {
            await SecureStore.setItemAsync("userPattern", currentHash);

            Haptics.notificationAsync(
              Haptics.NotificationFeedbackType.Success
            );

            Alert.alert(t.saved, t.savedMsg);
            setIsFirstTime(false);
            navigation.replace("Home");
          } else {
            if (currentHash === storedPattern) {
              attemptsRef.current = 0;

              Haptics.notificationAsync(
                Haptics.NotificationFeedbackType.Success
              );

              navigation.replace("Home");
            } else {
              attemptsRef.current += 1;

              if (attemptsRef.current >= 2) {
                attemptsRef.current = 0;
                triggerLockout();
              } else {
                Haptics.notificationAsync(
                  Haptics.NotificationFeedbackType.Warning
                );
                Alert.alert(t.incorrect, t.tryAgain);
              }
            }
          }
        }

        setSelected([]);
        selectedRef.current = [];
      },
    })
  ).current;

  /* ================= UI ================= */
  return (
    <View style={styles.container}>
      <View style={styles.langButtonContainer}>
        <Text style={styles.langButton} onPress={toggleLanguage}>
          {t.language}
        </Text>
      </View>

      <View style={styles.centerContent}>
        {isFirstTime && (
          <Text style={[styles.instructions, { color: ORANGE_COLOR }]}>
            {t.instructions}
          </Text>
        )}

        {isLocked() && (
          <Text style={{ color: "red", marginBottom: 10 }}>
            {t.locked}
          </Text>
        )}

        <View style={styles.grid} {...panResponder.panHandlers}>
          <Svg style={StyleSheet.absoluteFill}>
            {selected.map((id, i) => {
              if (i === 0) return null;

              const from = dots.find((d) => d.id === selected[i - 1]);
              const to = dots.find((d) => d.id === id);

              return (
                <Line
                  key={i}
                  x1={from.x}
                  y1={from.y}
                  x2={to.x}
                  y2={to.y}
                  stroke={FLUOR_COLOR}
                  strokeWidth={5}
                />
              );
            })}
          </Svg>

          {dots.map((dot) => (
            <View
              key={dot.id}
              ref={(ref) => (dotRefs.current[dot.id] = ref)}
              style={{
                position: "absolute",
                left: dot.x - 30,
                top: dot.y - 30,
              }}
            >
              <Dot isSelected={selected.includes(dot.id)} />
            </View>
          ))}
        </View>

        {!isFirstTime && (
          <View style={styles.biometricContainer}>
            <Text style={styles.biometricButton} onPress={tryBiometric}>
              🔒 {t.biometric}
            </Text>
          </View>
        )}
      </View>
    </View>
  );
}

/* ================= STYLES ================= */
const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: "#000",
    paddingTop: 100,
    alignItems: "center",
  },

  centerContent: {
    flex: 1,
    justifyContent: "center",
    alignItems: "center",
  },

  instructions: {
    fontSize: 16,
    marginBottom: 20,
  },

  grid: {
    width: 240,
    height: 220,
  },

  dot: {
    width: 60,
    height: 60,
    borderRadius: 30,
    borderWidth: 2,
    borderColor: FLUOR_COLOR,
    backgroundColor: "rgba(0,255,198,0.15)",
  },

  langButtonContainer: {
    position: "absolute",
    top: 50,
    right: 20,
  },

  langButton: {
    backgroundColor: "#00FFC6",
    padding: 8,
    borderRadius: 10,
    fontWeight: "bold",
  },

  biometricContainer: {
    position: "absolute",
    bottom: 60,
  },

  biometricButton: {
    backgroundColor: "#00FFC6",
    padding: 10,
    borderRadius: 12,
    fontWeight: "bold",
  },
});
