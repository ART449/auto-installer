#!/usr/bin/env bash
# ==============================================================================
# Auto-Installer — Script de Instalación Rápida
# Hecho por iArtLabs & el agente Antigravity (Google DeepMind)
# ==============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BIN_DIR="${HOME}/.local/bin"
DESKTOP_DIR="${HOME}/.local/share/applications"
ICON_DIR="${HOME}/.local/share/icons"
NAUTILUS_DIR="${HOME}/.local/share/nautilus/scripts"

echo "================================================================="
echo "  🐝 Auto-Installer · Instalador del Sistema"
echo "  Hecho por iArtLabs & Antigravity (Google DeepMind)"
echo "================================================================="

mkdir -p "${BIN_DIR}" "${DESKTOP_DIR}" "${ICON_DIR}" "${NAUTILUS_DIR}"

echo "[+] Copiando ejecutable a ${BIN_DIR}/auto-installer..."
cp -f "${SCRIPT_DIR}/bin/auto-installer" "${BIN_DIR}/auto-installer"
chmod +x "${BIN_DIR}/auto-installer"

echo "[+] Instalando iconos en ${ICON_DIR}..."
cp -f "${SCRIPT_DIR}/assets/icon.png" "${ICON_DIR}/auto-installer.png"
cp -f "${SCRIPT_DIR}/assets/icon.svg" "${ICON_DIR}/auto-installer.svg"

echo "[+] Registrando entrada de escritorio..."
cp -f "${SCRIPT_DIR}/desktop/auto-installer.desktop" "${DESKTOP_DIR}/auto-installer.desktop"
sed -i "s|Icon=auto-installer|Icon=${ICON_DIR}/auto-installer.png|g" "${DESKTOP_DIR}/auto-installer.desktop"

echo "[+] Agregando acción contextual a Nautilus..."
ln -sf "${BIN_DIR}/auto-installer" "${NAUTILUS_DIR}/⚡ Instalar o Desempaquetar"

if command -v update-desktop-database >/dev/null 2>&1; then
    update-desktop-database "${DESKTOP_DIR}" 2>/dev/null || true
fi

if command -v xdg-mime >/dev/null 2>&1; then
    xdg-mime default auto-installer.desktop application/vnd.debian.binary-package 2>/dev/null || true
fi

echo ""
echo "✔ Auto-Installer se ha instalado correctamente."
echo "  Puedes ejecutarlo desde el menú de aplicaciones, mediante clic derecho en Nautilus,"
echo "  o escribiendo 'auto-installer' en tu terminal."
echo "================================================================="
