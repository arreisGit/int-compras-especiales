USE [Cuprum]
GO

/****** Object:  StoredProcedure [dbo].[spCuprumEjecutaDespues]    Script Date: 06/03/2017 10:10:12 a.m. ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[spCuprumEjecutaDespues]
	@Modulo     CHAR(5),
	@ID         INT,
	@Accion     CHAR(20),
	@Base       CHAR(20),
	@GenerarMov CHAR(20),
	@Usuario    CHAR(10),
	@Ok         INT OUTPUT,
	@OkRef      VARCHAR(255) OUTPUT,      
	@FacturaID  INT OUTPUT,
	@IDGenerar  INT          = NULL
AS BEGIN
  
  SET ANSI_NULLS, ANSI_WARNINGS ON;

	DECLARE
		@Oid_gasto        INT,
		@Estatus          CHAR(15),
		@fecharegistro    DATETIME    = GETDATE(),
		@Mov              CHAR(20),
		@MovID            VARCHAR(20),
		@MovTipo          CHAR(20),
		@Cup_VtaMostrador BIT,
		@IdGasto          INT;

	IF @modulo = 'PROD'
	BEGIN
		-- Kike Sierra: 11/07/2013: Procedimiento para la cancelacion parcial de produccion.          
		EXEC dbo.spCuprumCancelacionParcialProd
			@Modulo,
			@ID,
			@Accion,
			@Base,
			@GenerarMov,
			@Usuario,
			@Ok OUTPUT,
			@Okref OUTPUT;

		-- Carlos Jimenez: 04/02/2015: Procedimiento para enviar correo del inventario actual del material puesto en la Orden de Produccion
		EXEC CUP_SPQ_InventarioProduccion
			@Modulo,
			@ID,
			@Accion;
	END;

	IF @modulo = 'INV'
	BEGIN
		-- Kike Sierra: 11/07/2013: Procedimiento para la la devolucion merma en las Ordenes Consumo          
		EXEC dbo.spCuprumCancelacionParcialProd
			@Modulo,
			@ID,
			@Accion,
			@Base,
			@GenerarMov,
			@Usuario,
			@Ok OUTPUT,
			@Okref OUTPUT;

		-- MZUNIGAF: 16/03/2015: Procedimiento para eliminar decimales en transitos y Concluirlos
		EXEC dbo.spCuprumConcluyeTransito
			@Modulo,
			@ID;

	END;

	IF @Modulo = 'VTAS'
	BEGIN

		-- Kike Sierra: 20/OCT/2015: 
		SELECT
			@Mov = v.Mov,
			@MovID = v.MovID,
			@MovTipo = t.Clave,
			@CUP_VtaMostrador = v.CUP_VtaMostrador,
			@Estatus = v.Estatus
		FROM
			Venta AS v
		JOIN movtipo AS t ON @Modulo = t.Modulo
													AND v.Mov = t.Mov
		WHERE
      v.ID = @ID;

		-- Kike Sierra: 15/10/2013 : Informa cuando una Orden C esta repetida          
		EXEC dbo.spCuprumInformaVtaOrdenC
			@Modulo,
			@ID,
			@Accion,
			@Base,
			@GenerarMov,
			@Usuario,
			@Ok OUTPUT,
			@Okref OUTPUT;

		-- Kike SIerra 20/04/2014: Procedimiento almacenado encargado de controlar el flujo de las Factuars Anticipo automaticas dentro del apartado de vtas        
		EXEC dbo.spCuprumVentaPedidoFactA
			@ID,
			@Usuario,
			2,
			@Accion,
			@GenerarMov,
			0;

		-- Kike Sierra: 27/06/2014 : Actualiza el DMovID del movflujo de las cotizaciones que se mandaron a venta perdida.        
		EXEC dbo.spCuprumCotizacionVtaPerdida
			@Modulo,
			@ID,
			@Accion,
			@Base,
			@GenerarMov,
			@Usuario,
			@Ok OUTPUT,
			@Okref OUTPUT;

		-- Erika Ramirez: 07/07/2014: Sp para llenar tabla de disposiciones en las devoluciones: Andres Balderas      
		EXEC CUP_Interface_Disposiciones
			@id,
			@Modulo;

		-- Kike Sierra:  08/Ene/2015: Procedimiento encargado de actualizar los valores de las facturas al caer en Cxc.
		EXEC CUP_SPU_VtasToCxcFields
			@Modulo,
			@ID,
			@MovTipo,
			@Accion;

		-- Kike Sierra: 01/10/2015 : Encargado de Facturar y Cobrar la Venta Mostrador.
		IF ISNULL(@CUP_VtaMostrador, 0) = 1
		BEGIN
			EXEC CUP_spp_FacturarVentaMostrador
				@Modulo = @Modulo,
				@ID = @ID,
				@Mov = @Mov,
				@MovID = @MovId,
				@MovTipo = @MovTipo,
				@Estatus = @Estatus,
				@EstatusNuevo = NULL,
				@Accion = @Accion,
				@Base = @Base,
				@GenerarMov = @GenerarMov,
				@Usuario = @Usuario,
				@Ok = @OK OUTPUT,
				@OkReF = @OkRef OUTPUT;

		END;

		-- Carlos Orozco: 11/07/2016: Generar Log Para Guardar la Estrategia Utilizada
		EXEC CUP_SPI_LogVentaDescuentos
			@ID,
			@Mov,
			@MovTipo;

		-- EBG: 2017-01-12: Concluye las ordenes de surtido  y pedidos que hayan quedado 
		-- en estatus PENDIENTE por tema de decimales
		EXEC CUP_SP_ConcluirPendienteEspecial
			@Usuario,
			@ID;

		-- Dev 23-01-2017: Ejecuta procesos despues de Afectar la Bonificacion desde Factura
		EXEC CUP_sp_DespuesBonificacionesFactura
			@Modulo,
			@ID,
			@Accion,
			@Base,
			@GenerarMov,
			@Usuario,
			@Ok OUTPUT,
			@Okref OUTPUT,
			@FacturaID,
			@IDGenerar;

	END;

	IF @Modulo = 'COMS'
	BEGIN

		-- Kike Sierra: 17/07/2013: Procedimiento para la actualizacion de la tabla CuprumAnexo,
    -- segun el certificado especificado en SerieLoteMov          
		EXEC dbo.spCuprumAnexoCertificado
			@Modulo,
			@ID,
			@Accion,
			@Base,
			@GenerarMov,
			@Usuario,
			@Ok OUTPUT,
			@Okref OUTPUT;

		-- Kike Sierra: 09/10/2013: Procedimiento encargado de aplicar de manera automática los anticipos a Entradas de Compra.          
		EXEC dbo.spCuprumAplicacionAutoAnticipoOrdenC
			@Modulo,
			@ID,
			@Accion,
			@Base,
			@GenerarMov,
			@Usuario,
			@Ok OUTPUT,
			@Okref OUTPUT;

		-- Kike Sierra: 09/04/2015: Procedimiento encargado de recalcular el vencimiento de los controles de calidad y sus Entradas.          
		EXEC dbo.spCMLRecalcularVencimientoCOMS
			@Modulo,
			@ID,
			@Accion,
			@Base,
			@GenerarMov,
			@Usuario,
			@Ok OUTPUT,
			@Okref OUTPUT;

		-- Procedimiento encargado de ejecutar los cambios de Costos Base y Metal de Compra.
		EXEC dbo.CUP_spAfectacionesEfectoOCCOMS
			@Modulo,
			@ID,
			@Accion,
			@Base,
			@GenerarMov,
			@Usuario,
			@Ok OUTPUT,
			@Okref OUTPUT,
			@IDGenerar;

    -- 

	END;

	IF @modulo = 'CXC'
	BEGIN
		--Kike SIerra 20/04/2014: Procedimiento almacenado encargado de controlar el flujo de las Factuars Anticipo automaticas dentro del apartado de cxc        
		EXEC spCuprumCxcPedidoFactA
			@ID,
			@Usuario,
			1,
			@Accion,
			@GenerarMov;

		--Kike Sierra: 30/07/2014: Actualiza la fecha de Vencimiento de un cheque devuelto .en base al cheque asignado      
		EXEC spCuprumVencimientoChequeDevuelto
			@Modulo,
			@ID,
			@Accion,
			'AVANZAR',
			@Ok OUTPUT,
			@OkRef OUTPUT;

	END;

	IF @modulo = 'CXP'
	BEGIN
		--Kike Sierra 01/10/2013: Procedimiento almacenado encargado de enviar correos automaticos sobre pagos.          
		EXEC dbo.spCuprumEnvioCorreoPagoProveedor
			@Modulo,
			@ID,
			@Accion,
			@Base,
			@GenerarMov,
			@Usuario,
			@Ok OUTPUT,
			@Okref OUTPUT;
	END;

	IF @modulo = 'DIN'
	BEGIN

		IF EXISTS
		(
			SELECT
				1
			FROM
				dbo.fnCMLMovFlujo('DIN', @id, 1) AS mf
			JOIN Cxp AS c ON c.ID = mf.oid
			WHERE
        mf.OMovTipo = 'CXP.A'
			AND c.GenerarDinero = 0
		)
		BEGIN
			DECLARE
				@oid INT;

			SELECT
				@oid = mf.OID
			FROM
				dbo.fnCMLMovFlujo('DIN', @id, 1) AS mf
			JOIN Cxp AS c ON c.ID = mf.oid
			WHERE
        mf.OMovTipo = 'CXP.A'
			AND c.GenerarDinero = 0;

			UPDATE CUP_anticipo
			SET
				id_estatus = 6
			WHERE
				ID_Anticipo = @oid;
		END;
	END;

	IF @modulo = 'EMB'
	BEGIN
		IF EXISTS
		(
			SELECT
				1
			FROM
				MovFlujo mf
			JOIN gasto g ON g.id = mf.dID
			JOIN Embarque e ON e.id = mf.OID
			WHERE
        mf.OModulo = 'EMB'
			AND OID = @id
			AND DModulo = 'GAS'
			AND DMov = 'Gastos Fletes'
			AND g.Estatus = 'Borrador'
			AND g.Situacion = 'Actualizar Datos'
			AND e.Estatus = 'Cancelado'
			AND Cancelado = 1
		)
		BEGIN
			SELECT
				@IdGasto = mf.DID
			FROM
				MovFlujo AS mf
			JOIN gasto AS g ON g.id = mf.dID
			JOIN Embarque AS e ON e.id = mf.OID
			WHERE
        mf.OModulo = 'EMB'
			AND e.Estatus = 'CANCELADO'
			AND OID = @id
			AND DModulo = 'GAS'
			AND DMov = 'Gastos Fletes'
			AND g.Estatus = 'Borrador'
			AND g.Situacion = 'Actualizar Datos'
			AND e.Estatus = 'Cancelado'
			AND Cancelado = 1;

			IF NOT EXISTS
			(
				SELECT
					1
				FROM
					EmpresaCfgValidarFechasEx
				WHERE
          Empresa = 'CML'
				AND Modulo = 'GAS'
				AND Mov = 'Gastos Fletes'
			)
			BEGIN
				INSERT INTO EmpresaCfgValidarFechasEx
				VALUES
				(
					'CML',
					'GAS',
					'Gastos Fletes'
				);
			END;

			IF NOT EXISTS
			(
				SELECT
					1
				FROM
					CuprumExcepcionMovPeriodoCerrado
				WHERE
          Empresa = 'CML'
				AND Modulo = 'GAS'
				AND Mov = 'Gastos Fletes'
			)
			BEGIN
				INSERT INTO CuprumExcepcionMovPeriodoCerrado
				VALUES
				(
					'CML',
					'GAS',
					'Gastos Fletes'
				);
			END;

			EXEC spAfectar
				'GAS',
				@idGasto,
				'CANCELAR',
				'Todo',
				NULL,
				'PRODAUT';

			DELETE FROM EmpresaCfgValidarFechasEx
			WHERE
				Modulo = 'GAS'
				AND Empresa = 'CML'
				AND Mov = 'Gastos Fletes';

			DELETE FROM CuprumExcepcionMovPeriodoCerrado
			WHERE
				Modulo = 'GAS'
				AND Empresa = 'CML'
				AND Mov = 'Gastos Fletes';
		END;
	END;

  /*** Apartado Varios ( Dos o mas modulos, donde no requiera que se valide el modulo antes de ejecutar el procedimiento)           
  ya sea por que dentro del mismo procedimiento lo valide. O el efecto sea igual para todos ***************************/

	-- Kike SIerra 12/09/2013: Procedimiento almacenado que genera traspasos automaicos a partir de un movimiento de pedido especifico.          
	EXEC dbo.spCUPRUMPedidoTraspasoAuto
		@Modulo,
		@ID,
		@Accion,
		@Base,
		@GenerarMov,
		@Usuario,
		1,
		@Ok OUTPUT,
		@Okref OUTPUT,
		@FacturaID OUTPUT;

	-- Kike SIerra 16/10/2013 Prcedimiento almacenado que se encarga de "arrastrar" la situacion en las afectaciones.          
	EXEC dbo.spCuprumArrastraSituacion
		@Modulo,
		@ID,
		@Accion,
		@Base,
		@GenerarMov,
		@Usuario,
		@Ok OUTPUT,
		@Okref OUTPUT;

	-- Kike Sierra: 03/09/2013: Procedimiento Almacenado Encargado de Disparar Gastos al concluir Embarques.          
	EXEC spCuprumEmbarqueGasto
		@Modulo,
		@ID,
		@Accion,
		@Base,
		@GenerarMov,
		@Usuario,
		@Ok OUTPUT,
		@Okref OUTPUT;

	-- Kike SIerra 01/07/2014 Prcedimiento almacenado que se encarga de "arrastrar" las facturas de compras y gasto a cxp.  
	EXEC dbo.spCuprumArrastraFacturasComsGas
		@Modulo,
		@ID,
		@Accion,
		@Base,
		@GenerarMov,
		@Usuario,
		@Ok OUTPUT,
		@Okref OUTPUT;

	-- Erika Ramirez: 04/08/2014: sp para enviar correo de clientes especiales al colocar pedidos: Carlos Jimenez    
	EXEC dbo.CUP_SPP_ValidaCteEspecial
		@id,
		@Modulo;

	IF @modulo = 'GAS'
	AND @Accion = 'CANCELAR'
	BEGIN

		UPDATE MovFlujo
		SET
			Cancelado = 1
		WHERE
			DModulo = 'GAS'
		AND OModulo = 'EMB'
		AND Cancelado = 0
		AND DID = @ID
		AND DMov = 'Gastos Fletes';

		-- Cuando el gasto se cancela, el embarque se le marca con la situacion de que se cancelo el gasto flete
		SELECT
			@Oid_gasto = Oid,
			@estatus = Embarque.Estatus
		FROM
			MovFlujo
		INNER JOIN embarque ON embarque.id = movflujo.oid
		WHERE
      DID = @ID
		AND DModulo = 'GAS'
		AND DMov = 'Gastos Fletes';

		IF @estatus NOT IN('CONCLUIDO', 'CANCELADO')
		BEGIN

			EXEC spCambiarSituacion
				'EMB',
				@Oid_gasto,
				'Gastos Fletes Cancelado',
				@fecharegistro,
				@Usuario,
				NULL,
				NULL;

		END;

	END;

	-- Kike Sierra 12/05/2015: Procedimiento Almacenado encargado de realizar los cambios en fecha requerida  de "Oferta Servicio" de las solicitudes Despues de afectar.
	EXEC spCMLServicioSolicitud
		@Modulo,
		@ID,
		@Accion,
		@Base,
		@GenerarMov,
		@Usuario,
		'DESPUESAFECTAR',
		@Ok OUTPUT,
		@OkRef OUTPUT;

  SET ANSI_NULLS, ANSI_WARNINGS OFF;

	RETURN;

END;