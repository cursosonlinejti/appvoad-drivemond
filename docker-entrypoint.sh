#!/bin/bash
set -e

# Executar script de configuração de permissões
echo "Configurando permissões para DriveMond..."
/usr/local/bin/setup-permissions.sh

# Continuar com o entrypoint padrão
exec "$@"