import React, { useState } from "react";
import { View, Text, StyleSheet, TouchableOpacity } from "react-native";
import MapView from "react-native-maps";

const actions = [
  "Shopping",
  "Selling",
  "Get SatNotes",
  "Redeem SatNotes",
  "SDTP Balance",
  "Verify a SatNote",
  "Join the Community",
  "Report an Issue/Bug",
];

export default function HomeScreen() {
  const [showMenu, setShowMenu] = useState(true);

  return (
    <View style={{ flex: 1 }}>
      <MapView
        provider={null} // ✅ works in Expo Go
        style={StyleSheet.absoluteFillObject}
        initialRegion={{
          latitude: 20.6597,
          longitude: -103.3496,
          latitudeDelta: 0.05,
          longitudeDelta: 0.05,
        }}
        onPress={() => setShowMenu(prev => !prev)}
      />

      {showMenu && (
        <View style={styles.menu}>
          {actions.map((item, i) => (
            <TouchableOpacity key={i} style={styles.menuBtn}>
              <Text style={styles.menuText}>{item}</Text>
            </TouchableOpacity>
          ))}
        </View>
      )}
    </View>
  );
}

const styles = StyleSheet.create({
  menu: {
    position: "absolute",
    top: 120,
    width: "100%",
    alignItems: "center",
  },

  menuBtn: {
    backgroundColor: "rgba(255,140,0,0.9)",
    paddingVertical: 12,
    width: "65%",
    borderRadius: 30,
    marginBottom: 22,
    alignItems: "center",
    elevation: 4,
  },

  menuText: {
    color: "white",
    fontSize: 16,
    fontWeight: "600",
  },
});
