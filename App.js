import React from "react";
import { NavigationContainer } from "@react-navigation/native";
import { createStackNavigator } from "@react-navigation/stack";

import AnimationScreen from "./src/screens/AnimationScreen";
import UnlockScreen from "./src/screens/UnlockScreen";
import HomeScreen from "./src/screens/HomeScreen";

const Stack = createStackNavigator();

export default function App() {
  return (
    <NavigationContainer>
      <Stack.Navigator initialRouteName="Animation">
        <Stack.Screen
          name="Animation"
          component={AnimationScreen}
          options={{ headerShown: false }}
        />
        <Stack.Screen
          name="Unlock"
          component={UnlockScreen}
          options={{ headerShown: false }}
        />
        <Stack.Screen
          name="Home"
          component={HomeScreen}
          options={{ headerShown: false }}
        />
      </Stack.Navigator>
    </NavigationContainer>
  );
}
