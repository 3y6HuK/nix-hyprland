#!/bin/bash

# Определяем реальное имя пользователя
CURRENT_USER=$(whoami)

# Пути к файлам (в текущей директории)
CONFIG_FILE="configuration.nix"
HOME_FILE="home.nix"
AUTOUP="autoupgrade-systemd"

# Проверяем существование файлов
if [[ ! -f "$CONFIG_FILE" ]]; then
  echo "Ошибка: файл '$CONFIG_FILE' не найден в текущей директории."
  exit 1
fi

if [[ ! -f "$HOME_FILE" ]]; then
  echo "Ошибка: файл '$HOME_FILE' не найден в текущей директории."
  exit 1
fi
i
f [[ ! -f "$AUTOUP" ]]; then
  echo "Ошибка: файл '$AUTOUP' не найден в текущей директории."
  exit 1
fi


echo "Найден пользователь: '$CURRENT_USER'"
echo "Обрабатываются файлы:"
echo "  - $CONFIG_FILE"
echo "  - $HOME_FILE"
echo "  - $AUTOUP"

# Создаём бэкапы
cp "$CONFIG_FILE" "${CONFIG_FILE}.backup"
cp "$HOME_FILE" "${HOME_FILE}.backup"
cp "$AUTOUP" "${AUTOUP}.backup"
echo "Созданы бэкапы: ${CONFIG_FILE}.backup, ${HOME_FILE}.backup, ${AUTOUP}.backup,"

# Заменяем 'username' на реальное имя пользователя
# Используем sed с разделителем '|' (чтобы избежать конфликтов с '/' в путях)
sed -i "s|username|$CURRENT_USER|g" "$CONFIG_FILE"
sed -i "s|username|$CURRENT_USER|g" "$HOME_FILE"
sed -i "s|username|$CURRENT_USER|g" "$AUTOUP"

echo "Замена завершена. Проверьте файлы:"
echo "  - $CONFIG_FILE"
echo "  - $HOME_FILE"
echo "  - $AUTOUP"
