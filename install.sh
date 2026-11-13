#!/usr/bin/env bash
# ==============================================================================
# INBEEBOX Auto-Installer — Script de Instalación Rápida
# Hecho por iArtLabs & el agente Antigravity (Google DeepMind)
# ==============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BIN_DIR="${HOME}/.local/bin"
DESKTOP_DIR="${HOME}/.local/share/applications"
ICON_DIR="${HOME}/.local/share/icons"
NAUTILUS_DIR="${HOME}/.local/share/nautilus/scripts"

echo "================================================================="
echo "  🐝 INBEEBOX Auto-Installer · Instalador del Sistema"
echo "  Hecho por iArtLabs & Antigravity (Google DeepMind)"
echo "================================================================="

# Crear directorios
mkdir -p "${BIN_DIR}" "${DESKTOP_DIR}" "${ICON_DIR}" "${NAUTILUS_DIR}"

# Instalar binario principal y alias
echo "[+] Copiando ejecutable a ${BIN_DIR}/inbeebox-installer..."
cp -f "${SCRIPT_DIR}/bin/inbeebox-installer" "${BIN_DIR}/inbeebox-installer"
chmod +x "${BIN_DIR}/inbeebox-installer"
ln -sf "${BIN_DIR}/inbeebox-installer" "${BIN_DIR}/auto-installer"

# Instalar iconos
echo "[+] Instalando iconos en ${ICON_DIR}..."
cp -f "${SCRIPT_DIR}/assets/icon.png" "${ICON_DIR}/inbeebox.png"
cp -f "${SCRIPT_DIR}/assets/icon.svg" "${ICON_DIR}/inbeebox.svg"

# Instalar entrada de escritorio (.desktop)
echo "[+] Registrando entrada de escritorio..."
cp -f "${SCRIPT_DIR}/desktop/inbeebox-installer.desktop" "${DESKTOP_DIR}/inbeebox-installer.desktop"
sed -i "s|Icon=inbeebox|Icon=${ICON_DIR}/inbeebox.png|g" "${DESKTOP_DIR}/inbeebox-installer.desktop"

# Integración con Nautilus (clic derecho)
echo "[+] Agregando script de menú contextual a Nautilus..."
ln -sf "${BIN_DIR}/inbeebox-installer" "${NAUTILUS_DIR}/⚡ Instalar o Desempaquetar"

# Actualizar base de datos MIME del usuario
if command -v update-desktop-database >/dev/null 2>&1; then
    update-desktop-database "${DESKTOP_DIR}" 2>/dev/null || true
fi

# Asociar paquetes .deb
if command -v xdg-mime >/dev/null 2>&1; then
    xdg-mime default inbeebox-installer.desktop application/vnd.debian.binary-package 2>/dev/null || true
fi

echo ""
echo "✔ INBEEBOX Auto-Installer se ha instalado correctamente."
echo "  Puedes ejecutarlo desde el menú de aplicaciones, mediante clic derecho en Nautilus,"
echo "  o escribiendo 'auto-installer' en tu terminal."
echo "================================================================="
