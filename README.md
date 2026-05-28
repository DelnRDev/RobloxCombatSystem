# Roblox PvP Combat System

A server-authoritative melee combat system built with Luau, Rojo, and Roblox Studio.

## Features

- Multiplayer PvP combat
- Server-side damage validation
- Distance-based hit detection
- Attack cooldown system
- Closest-target selection
- RemoteEvent client/server communication

## Technologies Used

- Roblox Studio
- Luau
- Rojo
- VS Code

## Architecture

Client:
- Detects player input
- Sends attack requests to server

Server:
- Validates attack cooldown
- Checks combat range
- Finds closest valid target
- Applies damage through Humanoid system

## Combat Flow

```text
Player clicks attack
↓
Client fires RemoteEvent
↓
Server validates attack
↓
Server finds nearest target in range
↓
Target takes damage
```

## Important Concepts

- Server-authoritative combat
- RemoteEvents
- Cooldown management
- Character validation
- Distance calculations using Vector3 magnitude
- CFrame / Humanoid systems

## Future Improvements

- Sword hitboxes
- Combat animations
- Blocking/parrying
- Dash mechanics
- Weapon stats
- Combo system
- Raycast hit detection