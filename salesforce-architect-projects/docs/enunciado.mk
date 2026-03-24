Perfeito — vou te entregar isso como um **README.md pronto**, no nível que você colocaria direto no GitHub 👇

---

# 📄 Desafio — Segurança de Dados e Controle de Acesso no Salesforce

## 🧠 Objetivo

Construir um sistema em Salesforce que implemente controle de acesso completo utilizando:

* Object-Level Security (Profiles / Permission Sets)
* Record-Level Security (OWD, Role Hierarchy, Sharing Rules)
* Apex Sharing

O objetivo é simular um cenário real de empresa com regras de acesso bem definidas.

---

## 🏢 Contexto de Negócio

Uma empresa possui times comerciais responsáveis por criar contratos para clientes.

Esses contratos:

* Não devem ser visíveis para todos os usuários
* Precisam ser acessados apenas por pessoas autorizadas
* Devem passar por um fluxo de aprovação
* Precisam ser acessíveis por áreas específicas (ex: Financeiro)

---

## 🧩 Domínio do Problema

Você deve modelar:

* Usuários com diferentes papéis (Sales, Manager, Finance)
* Contratos vinculados a contas
* Regras de acesso dinâmicas e controladas

---

## 📦 Escopo Técnico

---

### 🧱 1. Modelagem de Dados

Criar objeto customizado:

#### `Contract__c`

Campos obrigatórios:

| Campo             | Tipo            |
| ----------------- | --------------- |
| Name              | Text            |
| Status__c         | Picklist        |
| Account__c        | Lookup(Account) |
| Manager__c        | Lookup(User)    |
| Backup_Manager__c | Lookup(User)    |

#### Valores do Status__c:

* Draft
* Pending Approval
* Approved
* Rejected

---

### 🔐 2. Segurança — Nível de Objeto

Configurar:

* Profiles ou Permission Sets

Regras:

* Usuários podem:

  * Criar
  * Ler
  * Editar
* Usuários **não devem ter acesso global aos registros**

---

### 🔒 3. Segurança — Nível de Registro

#### OWD (Obrigatório)

* `Contract__c = Private`

---

#### Role Hierarchy

* Managers devem acessar registros criados por usuários abaixo deles na hierarquia

---

#### Sharing Rules

Criar:

* Public Group: `Finance`

Regra:

* Grupo Finance → acesso de leitura (`Read`) a todos os contratos

---

### 🔴 4. Apex Sharing (Core do Desafio)

Implementar lógica de compartilhamento manual.

#### Requisitos:

Sempre que um `Contract__c` for criado ou atualizado:

Compartilhar com:

* `Manager__c` → acesso `Edit`
* `Backup_Manager__c` → acesso `Edit`

---

#### ⚠️ Regras importantes:

* Evitar duplicação de registros em `Contract__Share`
* Atualizar shares quando os usuários mudarem
* Remover shares antigos quando necessário
* Implementação deve ser **idempotente**

---

### ⚙️ 5. Automação

Criar Trigger em `Contract__c`:

#### Eventos:

* `after insert`
* `after update`

#### Responsabilidades:

* Delegar lógica para uma classe de serviço
* Garantir consistência do compartilhamento

---

### 🧠 6. Arquitetura de Código

Separar responsabilidades:

* **Trigger** → orquestração
* **Service Layer** → lógica de compartilhamento
* (Opcional) Domain Layer

---

#### Regras obrigatórias:

* Clean Code
* KISS (Keep It Simple)
* YAGNI (You Aren’t Gonna Need It)
* Sem bibliotecas externas

---

### 🔐 7. Segurança no Código

Garantir:

* Uso de `with sharing`
* Verificação de CRUD/FLS
* Uso de `Security.stripInaccessible` quando necessário

---

### 🧪 8. Testes

Criar classe de teste cobrindo:

#### Cenários:

* Criação de contrato
* Manager recebe acesso
* Backup Manager recebe acesso
* Finance possui acesso de leitura
* Usuário sem acesso não consegue visualizar
* Alteração de Manager atualiza compartilhamento
* Não ocorre duplicação de shares

---

#### Requisitos:

* Cobertura mínima: **90%**
* Testes independentes
* Uso de dados controlados

---

## 🚀 Critérios de Sucesso

Você completou corretamente se:

* Consegue explicar como o Salesforce calcula acesso
* Utilizou corretamente todos os níveis de segurança
* O código está limpo e simples
* O compartilhamento funciona corretamente
* Os testes cobrem cenários reais

---

## 🔥 Nível 2 (Desafio Avançado)

Refatorar a solução para responder:

> Como resolver este problema **sem usar Apex Sharing**?

---

## 🔥 Nível 3 (Escalabilidade)

* Simular grande volume (50k+ registros)
* Avaliar impacto de sharing
* Propor melhorias de performance

---

## 🧠 Estratégia de Execução

### ❌ Não fazer:

* Delegar toda implementação para IA

---

### ✅ Fazer:

1. Implementar manualmente
2. Utilizar IA (Codex) para revisão

---

### Exemplos de prompts úteis:

```text
Revise minha arquitetura e identifique problemas de segurança e escalabilidade
```

```text
Refatore esse código seguindo KISS e Clean Code
```

```text
Quais são os anti-patterns nessa implementação?
```

---

## 🧠 Objetivo Final

Este desafio não é sobre código.

É sobre aprender a pensar como:

> **Salesforce Architect**

---

Se quiser, no próximo passo a gente pode fazer algo MUITO forte:

👉 você começa a implementar
👉 me manda sua primeira versão
👉 eu faço um code review nível Big Tech (sem dó 😄)

Isso aqui acelera MUITO tua evolução.
