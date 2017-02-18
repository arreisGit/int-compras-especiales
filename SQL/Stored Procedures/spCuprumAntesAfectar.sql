USE [Cuprum];
GO

/****** Object:  StoredProcedure [dbo].[spCuprumAntesAfectar]    Script Date: 17/02/2017 01:42:44 p.m. ******/

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

ALTER PROCEDURE [dbo].[spCuprumAntesAfectar]
	@Modulo     CHAR(5),
	@ID         INT,
	@Accion     CHAR(20),
	@Base       CHAR(20),
	@GenerarMov CHAR(20),
	@Usuario    CHAR(10),
	@Ok         INT OUTPUT,
	@OkRef      VARCHAR(255) OUTPUT
AS BEGIN

	DECLARE
		@FechaRequerida DATE,
    @Estatus        CHAR(15),
		@Mov            CHAR(20),
    @MovTipo        CHAR(20),
    @GenerarMovTipo  CHAR(20);

	IF @Modulo = 'VTAS'
	BEGIN

		--Mike Zuñiga: 25/10/2016: Procedimiento Almacenado encargado de limpiar informacion basura del mov cuando el Cliente no sea Mostrador
		EXEC CUP_SPD_VtaLimpiarMovAntesAfectar
			@modulo,
			@ID,
			@Accion;

		--Kike Sierra: 21/04/2014: Procedimiento ALmacenado encargado de ejecutar acciones del FLujo de Facturas Anticipo  Automaticas en el Antes Afectar      
		EXEC spCuprumAntesAfectarVentaPedidoFactA
			@modulo,
			@ID,
			@Accion,
			@Base,
			@GenerarMov,
			@Usuario,
			@Ok OUTPUT,
			@OkRef OUTPUT;

		--Kike Sierra: 20/05/2014 : Recalcula el Campo DEscuentoImporte del detalle.    
		EXEC dbo.spCuprumVentaDRecalcDescImp
			@Modulo,
			@ID,
			@Accion,
			@Base,
			@GenerarMov,
			@Usuario,
			@Ok OUTPUT,
			@Okref OUTPUT;

		--Kike Sierra: 19/09/2014:[POST MIGRACION] Proceso que valida que los Descuentos lineas concuerden con los precios descontados ya redondeados.  
		EXEC spCuprumVentaDescuentosLinea
			@modulo,
			@ID,
			@Accion,
			@Base,
			@GenerarMov,
			@Usuario,
			@Ok OUTPUT,
			@OkRef OUTPUT;

		--Kike Sierra: 11/08/2014 : Verifica e Inserta el valor predeterminado de el horario cliente embarque en un pedido
		EXEC dbo.spCuprumVtaCteEmbarqueHorario
			@Modulo,
			@ID,
			@Accion,
			@Base,
			@GenerarMov,
			@Usuario,
			@Ok OUTPUT,
			@Okref OUTPUT;

		--Kike Sierra: 13/ABR/2016: Procedimiento encargado de actualizar el canal de venta de las solicitudes devolucion,
		-- devoluciones y bonificaciones antes de afectar e independientemente de si el movimiento se realizo por Intelisis.
		EXEC CUP_SPU_CanalDeVenta
			@Modulo,
			@ID,
			@Accion,
			@Base,
			@GenerarMov,
			@Usuario,
			@Ok OUTPUT,
			@Okref OUTPUT;

		IF @ACCION <> 'CANCELAR'
		BEGIN

			IF
			(
				SELECT
					t.clave
				FROM
					venta AS v
				JOIN movtipo AS t ON v.Mov = t.Mov
															AND t.Modulo = 'VTAS'
				WHERE
          v.id = @iD
			) IN (
            'VTAS.C',
            'VTAS.P',
            'VTAS.S',
            'VTAS.PR',
            'VTAS.EST',
            'VTAS.F'
			      )
			BEGIN
				SELECT
					@FechaREquerida = MAX(FechaRequerida)
				FROM
					VentaD
				WHERE
          id = @ID;

				IF @FechaRequerida IS NOT NULL
				BEGIN
					UPDATE
            venta
					SET
						FechaRequerida = @FechaRequerida
					WHERE
						id = @ID
				END;
			END;
			ELSE
			BEGIN
				IF
				(
					SELECT
						t.clave
					FROM
						venta AS v
					JOIN movtipo AS t ON v.Mov = t.Mov
																AND t.Modulo = 'VTAS'
					WHERE
            v.id = @iD
				) IN
				('VTAS.SD'
				)
				BEGIN

					UPDATE venta
					SET
						FechaRequerida = FechaEmision
					WHERE
						id = @ID;

					UPDATE
            d
					SET
						d.FechaRequerida = v.FechaEmision
					FROM
            VentaD d
					JOIN venta v ON d.ID = v.ID
					WHERE
						d.id = @id;
				END;
			END;

		END;
	END;

	IF @Modulo = 'CXC'
	BEGIN
		--Kike Sierra: 13/01/2015: Proceso encargado de Actaulizar la retencion de un cobro antes de afectar para los clientes grado RETEN  
		EXEC xpCuprumCxcRetencionCalcular
			@modulo,
			@ID,
			@Accion,
			@Base,
			@GenerarMov,
			@Usuario,
			@Ok OUTPUT,
			@OkRef OUTPUT;

		SELECT
			@Mov = Mov
		FROM
			CXC
		WHERE
      ID = @ID;

	END;

	IF @Modulo = 'COMS'
	BEGIN

    SELECT
      @Estatus = c.Estatus,
      @Mov = t.Mov,
      @MovTipo = t.Clave,
      @GenerarMovTipo = gt.Clave
    FROM 
      Compra c 
    JOIN Movtipo t ON t.Modulo = 'COMS'
                  AND t.Mov = c.Mov
    LEFT JOIN Movtipo gt ON gt.Modulo ='COMS'
                        AND gt.Mov = @GenerarMov
    WHERE 
      c.Id = @ID

		--Kike Sierra: 11/03/2015: Proceso encargado de Recalcular la Fecha Vencimiento de los Controles Calidad, en base a la fecha factura.
		EXEC spCuprumVencimientoCOMS
			@modulo,
			@ID,
			@Accion,
			@Base,
			@GenerarMov,
			@Usuario,
			@Ok OUTPUT,
			@OkRef OUTPUT;

		/*Valida y Corrige las Fechas Requeridas*/

		EXEC spCuprumFechaRequeridaCOMS
			@modulo,
			@ID,
			@Accion,
			@Base,
			@GenerarMov,
			@Usuario,
			@Ok OUTPUT,
			@OkRef OUTPUT;

		/*Validaciones desde OC, --CostoMetal,CostoBase y posteriorment mas*/
		EXEC CUP_spValidacionesEfectoOCCOMS
			@modulo,
			@ID,
			@Accion,
			@Base,
			@GenerarMov,
			@Usuario,
			@Ok OUTPUT,
			@OkRef OUTPUT;

    -- Kike Sierra: 2017-02-17: Procedimiento encargado de llevar el registro de las  
    -- compras especiales.
    EXEC CUP_SPI_ComprasEspeciales_RegistroLog
      @Modulo,  
      @ID,
      @Accion,
      @Base,
      @Estatus,
      @Mov,
      @MovTipo,
      @GenerarMov,
      @GenerarMovTipo,
      @Usuario,
      @OK OUTPUT,
      @OkRef OUTPUT       
     
	END;

	/*Apartado Varios*/
	--Kike Sierra: 16/07/2014: Procedimiento ALmacenado encargado de Actualizar los datos del Cliente Mostrador antes de afectar    
	-- una factura o Factura Anticipo    
	EXEC spCuprumVtasCteMostrador
		@Modulo,
		@ID,
		@Accion,
		NULL,
		@Ok OUTPUT,
		@OkRef OUTPUT;

	--Kike Sierra: 31/03/2015: Se asegura que al afectar movimientos que timbre CFDI no exista un  registro en cfd hasta que  no  sean timbrados
	EXEC spCMLLimpiarCFD
		@Modulo,
		@ID,
		@Accion,
		@Base,
		@GenerarMov,
		@Usuario,
		@Ok OUTPUT,
		@OkRef OUTPUT;

	IF @Modulo = 'INV'
	BEGIN
		--Kike Sierra 12/05/2015: Procedimiento Almacenado encargado de realizar los cambios en fecha requerida  de "Oferta Servicio" de las solicitudes Antes de afectar.
		EXEC spCMLServicioSolicitud
			@Modulo,
			@ID,
			@Accion,
			@Base,
			@GenerarMov,
			@Usuario,
			'ANTESAFECTAR',
			@Ok OUTPUT,
			@OkRef OUTPUT;
	END;

	RETURN;
END;