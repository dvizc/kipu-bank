# Kipu Bank
KipuBank es un contrato inteligente descentralizado en la red Ethereum que funciona como una bóveda personal. Permite a los usuarios depositar y retirar Ether (ETH) de forma segura, aplicando reglas para proteger los fondos y mantener la estabilidad del sistema.

## 📌 Funcionalidades
- Depositar ETH en una bóveda personal
- Retirar ETH de la bóveda personal con un límite máximo
- Consultar saldo
- Contador de depositos y retiros

## 📜 Prerrequisitos
1.  **Wallet**: Una wallet de navegador como [MetaMask](https://metamask.io/).
2.  **Testnet ETH**: Obtén ETH de prueba para la red Sepolia desde un faucet como [sepoliafaucet.com](https://sepoliafaucet.com/).
3.  **IDE**: Se recomienda usar [Remix IDE](https://remix.ethereum.org/) para un despliegue sencillo.

## 🚀 Despliegue
1. Abrir [Remix IDE](https://remix.ethereum.org/).
2. Crear la carpeta `contracts/` y pegar `KipuBank.sol`.
3. En la pestaña **Solidity Compiler** seleccionar `0.8.0`.
4. Compilar el contrato.
5. Ir a **Deploy & Run Transactions**.
6. Seleccionar ambiente **Injected Provider - MetaMask** (red de prueba Sepolia).
7. Ingresar los parámetros:
   - `bankCap`: capacidad de la bóveda (ej. `100000000000000000000` para 100 ETH).
   - `MAX_RETIRO`: límite máximo por retiro (ej. `5000000000000000000` para 5 ETH).
8. Clic en **Deploy**.
9. Confirmar la transacción en Metamask.

## ⚙️ Cómo interactuar
Puedes interactuar con las funciones del contrato directamente desde Remix, Etherscan o a través de una aplicación descentralizada.

### Funciones Principales

#### `deposit()`

Permite depositar ETH en la bóveda personal.

1.  En Remix, en la sección "Deployed Contracts", busca la función `deposit`.
2.  En el campo **VALUE**, ingresa la cantidad de ETH que deseas depositar (puedes seleccionar la unidad: wei, gwei, finney, ether).
3.  Clic en el botón rojo `deposit` y confirma la transacción en MetaMask.

#### `retiro(uint256 _monto)`

Permite retirar ETH de tu bóveda.

1.  Ingresa la cantidad que deseas retirar (en wei) en el campo `_monto` junto a la función `retiro`.
2.  Clic en el botón `retiro` y confirma la transacción.
3.  La transacción fallará si intentas retirar más de lo que tienes o si el monto supera el `MAX_RETIRO`.

#### `obtenerSaldo(address _user)`

Consulta el saldo de cualquier usuario.

1.  Ingresa la dirección de la wallet que quieres consultar en el campo `_user`.
2.  Haz clic en el botón azul `obtenerSaldo` para ver el resultado. Esta es una llamada de solo lectura y no cuesta gas.

## Verificar la dirección de contrato

1.  Ingresar a [Etherscan](https://sepolia.etherscan.io/)
2.  Buscar la dirección del contrato (ej.0x9fbe7564fc263d427728580735a6c4052c813f4450e0e98146b715b43a89ec43)

**Dirección del Contrato en Sepolia Testnet:**
> [https://sepolia.etherscan.io/tx/0x9fbe7564fc263d427728580735a6c4052c813f4450e0e98146b715b43a89ec43]