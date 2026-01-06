# AMAL - Automação Modular de Ambiente Linux 

Projeto **bootstrap automatizado de ambientes Linux**, focado em preparar sistemas novos de forma **segura, repetível, modular e consistente**.

O projeto evoluiu para uma **arquitetura modular**, onde cada responsabilidade do sistema é isolada em um módulo específico, facilitando manutenção, testes e extensões futuras.

---

## 🚀 Propósito

Automatizar a configuração inicial de ambientes Linux para desenvolvimento e uso geral, incluindo:

* Atualização do sistema
* Instalação de pacotes essenciais
* Configuração completa do Docker
* Preparação do ambiente Python
* Geração opcional de chave SSH (interativa)
* Customização do shell via `.bashrc`

Compatível com **Ubuntu**, **Debian**, **Fedora** e **Arch Linux**.

---

## 🧱 Arquitetura do Projeto

```
amal/
├── install.sh          # Orquestrador principal
├── README.md           # Documentação
└── lib/
    ├── core.sh         # Funções base (log, validações, helpers)
    ├── distro.sh       # Detecção de distro e definição do gerenciador de pacotes
    ├── packages.sh     # Atualização do sistema e pacotes essenciais
    ├── docker.sh       # Instalação e configuração do Docker
    ├── python.sh       # Ambiente Python (python, pip, venv)
    ├── ssh.sh          # Geração interativa de chave SSH
    └── bashrc.sh       # Configuração idempotente do .bashrc
```

Cada módulo possui **uma responsabilidade única (SRP)** e pode ser evoluído ou substituído de forma independente.

---

## ⚙️ O que o script faz?

### 🔍 Core e preparação

* Garante execução em Bash
* Valida `sudo`
* Centraliza funções de log (`info`, `warn`, `success`, `error`)

### 🐧 Detecção de distribuição

* Identifica automaticamente a distro via `/etc/os-release`
* Define:

  * Gerenciador de pacotes (`apt`, `dnf`, `pacman`)
  * Comandos padronizados de update e install

### 📦 Pacotes essenciais

Instala de forma idempotente:

* `neofetch`
* `tmux`
* `htop`
* `curl`
* `git`

> O cache do sistema é atualizado apenas **uma vez**, mesmo que múltiplos módulos dependam dele.

### 🐳 Docker

* Instala o pacote correto por distro
* Habilita e inicia o serviço Docker
* Adiciona o usuário atual ao grupo `docker`
* Evita reconfigurações desnecessárias

> ⚠️ É necessário logout/login ou reboot para usar Docker sem `sudo`.

### 🐍 Ambiente Python

* Instala Python, pip e venv conforme a distro
* Valida versões instaladas
* Não instala bibliotecas globais automaticamente

### 🔐 SSH (interativo)

* Verifica se já existe uma chave `ed25519`
* Pergunta se o usuário deseja gerar uma nova chave
* Solicita o e-mail via CLI
* Gera a chave de forma segura
* Exibe a chave pública ao final

> Nunca sobrescreve chaves existentes sem consentimento explícito.

### 🖥️ Shell (.bashrc)

* Insere aliases e funções no `~/.bashrc`
* Usa **marcadores exclusivos** para garantir idempotência
* Remove automaticamente blocos antigos antes de reaplicar

---

## 🗒️ Aliases e funções adicionados

### 📁 Navegação

* `ll`, `la`, `l`

### 🔧 Utilitários

* `cls` → limpa o terminal
* `neo` → exibe informações do sistema
* `internet` → testa conectividade

### 🖥️ Sistema (use com cautela)

* `sN` → shutdown imediato
* `rB` → reboot imediato

### 🐍 Python

* `py` → python3
* `pipup` → atualiza o pip
* `venv` → cria ambiente virtual padrão

### 🔄 Atualização do sistema

* `update` → comando adaptado automaticamente à distro

### 🔍 Funções

* `mostrar <alias>` → exibe a definição de um alias

---

## 🛠️ Pré-requisitos

* Linux (Ubuntu, Debian, Fedora ou Arch)
* Usuário com privilégios `sudo`
* Shell Bash
* Conexão com a internet

---

## 📥 Instalação

1. Clone o repositório:

```bash
git clone git@github.com:Ujs74wiop6/amal.git
cd amal
```

2. Conceda permissão de execução:

```bash
chmod +x install.sh
```

3. Execute o script:

```bash
./install.sh
```

---

## 💡 Observações Importantes

* O script é **totalmente idempotente**
* Pode ser executado múltiplas vezes com segurança
* A arquitetura modular facilita auditoria e manutenção
* A geração de chave SSH é **opcional e interativa**
* Recomenda-se revisar aliases antes de uso em ambientes críticos

---

## ✅ Status do Projeto

* ✔ Multidistro
* ✔ Modular
* ✔ Idempotente
* ✔ Arquitetura limpa
