// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title KipuBank
 * @author Dome
 * @notice Este contrato implementa una bóveda personal para ETH.
 */
contract KipuBank {
    /**
     * @notice Límite máximo de ETH que el banco puede almacenar en total.
     */
    uint256 public immutable bankCap;

    /**
     * @notice Umbral máximo de retiro por transacción para cualquier usuario.
     */
    uint256 public immutable MAX_RETIRO;

    /**
     * @notice Mapeo de la dirección de un usuario al saldo de su bóveda personal.
     */
    mapping(address => uint256) private cuenta;

    /**
     * @notice El total de ETH depositado actualmente en el contrato.
     */
    uint256 private totalDepositado;

    /**
     * @notice Contador del número total de depósitos realizados en el contrato.
     */
    uint256 public depositoContador;

    /**
     * @notice Contador del número total de retiros realizados en el contrato.
     */
    uint256 public retiroContador;

    /**
     * @notice Se emite cuando un usuario deposita fondos exitosamente.
     * @param user La dirección del usuario que realiza el depósito.
     * @param monto La cantidad de ETH depositada.
     */
    event Depositado(address indexed user, uint256 monto);

    /**
     * @notice Se emite cuando un usuario retira fondos exitosamente.
     * @param user La dirección del usuario que realiza el retiro.
     * @param monto La cantidad de ETH retirada.
     */
    event Retiro(address indexed user, uint256 monto);
    
    // Los custom errors han sido eliminados para usar require con strings.

    /**
     * @notice Inicializa el contrato estableciendo los límites inmutables.
     * @param _bankCap El límite total de depósitos para el contrato.
     * @param _MAX_RETIRO El límite máximo por transacción de retiro.
     */
    constructor(uint256 _bankCap, uint256 _MAX_RETIRO) {
        bankCap = _bankCap;
        MAX_RETIRO = _MAX_RETIRO;
    }

    /**
     * @notice Permite a un usuario depositar ETH en su bóveda personal.
     * La función revertirá si se intenta depositar 0, o si el depósito excede la capacidad total del banco.
     */
    function deposit() external payable {
        uint256 monto = msg.value;
        
        require(monto > 0, "El monto a depositar debe ser mayor que 0.");
        require(totalDepositado + monto <= bankCap, "El deposito excede la capacidad del banco.");

        cuenta[msg.sender] += monto;
        totalDepositado += monto;
        depositoContador++;

        emit Depositado(msg.sender, monto);
    }

    /**
     * @notice Permite a un usuario retirar una cantidad específica de ETH de su bóveda.
     * @param _monto La cantidad de ETH a retirar.
     */
    function retiro(uint256 _monto) external {
        
        require(_monto > 0, "El monto a retirar debe ser mayor que 0.");
        require(cuenta[msg.sender] >= _monto, "Saldo insuficiente para el retiro.");
        require(_monto <= MAX_RETIRO, "Se ha excedido el limite de retiro por transaccion.");

        cuenta[msg.sender] -= _monto;
        totalDepositado -= _monto;
        retiroContador++;

        // --- Interacción Externa ---
        (bool success, ) = msg.sender.call{value: _monto}("");
        require(success, "La transferencia de ETH ha fallado.");

        emit Retiro(msg.sender, _monto);
    }

    /**
     * @notice Obtiene el saldo de la bóveda de un usuario específico.
     * @param _user La dirección del usuario a consultar.
     * @return El saldo actual en wei del usuario.
     */
    function obtenerSaldo(address _user) external view returns (uint256) {
        return cuenta[_user];
    }
    
}