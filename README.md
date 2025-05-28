# 🚀 DulcePan App: Despliegue y Guía de Compilación (Web e iOS)

Este proyecto contiene una aplicación desarrollada en **Flutter** para la panadería **DulcePan**, lista para ser ejecutada en:
✅ Web (desplegada en Vercel).  
✅ iOS (compilada en Xcode y ).

---

## 🌐 Versión Web (Vercel)

La app web se encuentra desplegada en Vercel.  
Para revisarla:

👉 Accede a:  
https://dulcepan.vercel.app

👉 El contenido web se encuentra en la carpeta:  
build/web/

---

## 📱 Versión iOS (Compilación y Pruebas)

### ⚙️ Requisitos previos

- Mac con **Xcode** y **CocoaPods** instalados.
- Tener instalado **Flutter** y el SDK de iOS:
  flutter doctor

### 🟩 1️⃣ Genera el proyecto para iOS

En la terminal:
flutter build ios --release

### 🟩 2️⃣ Abre el proyecto en Xcode

open ios/Runner.xcworkspace

### 🟩 3️⃣ Configura la cuenta de desarrollador y firma

- En Xcode, selecciona el proyecto `Runner` en la barra lateral.

### 🟩 4️⃣ Prueba en simulador o dispositivo real

En Xcode:

- Selecciona el dispositivo o simulador.
- Haz clic en `▶️ Run`.

---

## 📦 Estructura de carpetas relevantes

build/web/ # Contenido web generado
ios/ # Proyecto iOS (listo para compilar en Xcode)
lib/ # Código fuente en Flutter

---

## ℹ️ Notas finales

- Esta guía está lista para que cualquier persona con las credenciales y herramientas pueda **ver la app en web** y **compilarla en iOS**.

¡Listo para que pruebes la app de DulcePan en todas las plataformas! 🚀✨
