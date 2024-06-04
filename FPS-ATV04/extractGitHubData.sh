#!/bin/bash
# Esse código lê um perfil do GitHub e extrai dados relevantes, os exibe em uma caixa de diálogo e salva em um arquivo de texto na pasta backup.
# Diretório de backup
backup_dir="backup"

# Verifica se o diretório de backup existe, se não, cria
if [ ! -d "$backup_dir" ]; then
    mkdir -p "$backup_dir"
fi

# Função para obter a entrada do link
get_link() {
    link=$(dialog --title "Entrada de Link" --inputbox "Por favor, insira o link de um perfil do GitHub:" 8 50 3>&1 1>&2 2>&3 3>&-)
    clear
}

# Função para baixar o HTML do link fornecido
download_html() {
    wget -O downloaded_page.html "$link"

    if [ $? -eq 0 ]; then
        extract_data
    else
        dialog --title "Erro" --msgbox "Falha ao baixar o HTML. Verifique o link e tente novamente." 6 50
        exit 1
    fi
}

# Função para extrair dados do HTML baixado
extract_data() {

    username=$(awk -v RS='<|>' '/strong/{getline; print $0}' downloaded_page.html | sed -n '1p')
    #garante que o nome vai ser seguro para nomear arquivos e pastas
    username_safe=$(echo "$username" | tr -d '[:space:]' | tr -d '[:punct:]')
    seguidores=$(awk -v RS='<|>' '/span class="text-bold color-fg-default"/{getline; print $0}' downloaded_page.html | sed -n '1p')
    seguindo=$(awk -v RS='<|>' '/span class="text-bold color-fg-default"/{getline; print $0}' downloaded_page.html | sed -n '2p')
    repositorios=$(awk -v RS='<|>' '/span title/ && /class="Counter"/{getline; print $0}' downloaded_page.html | sed -n '1p')
    estrelas=$(awk -v RS='<|>' '/span title/ && /class="Counter"/{getline; print $0}' downloaded_page.html | sed -n '4p')
    
    dialog --title "Dados Extraídos" --msgbox   "Nome do usuário: $username
                                                \nSeguidores: $seguidores
                                                \nSeguindo: $seguindo
                                                \nEstrelas: $estrelas
                                                \nRepositórios Públicos: $repositorios" 15 50
    mkdir -p "$backup_dir/$username_safe"
    # Salvar os dados extraídos em um arquivo de texto com o nome do usuário
    echo -e "Nome do usuário: $username\nSeguidores: $seguidores\nSeguindo: $seguindo\nEstrelas: $estrelas\nRepositórios Públicos: $repositorios" > "$backup_dir/$username_safe/$username_safe.txt"
    cp downloaded_page.html "$backup_dir/$username_safe/$username_safe.html"
    # Zipa a pasta de backup
    zip -r "$backup_dir.zip" "$backup_dir"
}

# Executa as funções
get_link
download_html

# Limpa a tela no final
clear
