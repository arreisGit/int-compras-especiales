USE [Cuprum]
GO

/****** Object:  StoredProcedure [dbo].[xpInvAfectarAntes]    Script Date: 06/03/2017 03:26:45 p.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

ALTER PROCEDURE [dbo].[xpInvAfectarAntes]
  @ID                		int,
  @Accion			char(20),
  @Base			char(20),
  @Empresa	      		char(5),
  @Usuario			char(10),
  @Modulo	      		char(5),
  @Mov	  	      		char(20),
  @MovID             		varchar(20),
  @MovTipo     		char(20),
  @MovMoneda	      		char(10),
  @MovTipoCambio	 	float,
  @Estatus	 	      	char(15),
  @EstatusNuevo	      	char(15),
  @FechaEmision		datetime,
  @FechaRegistro		datetime,
  @FechaAfectacion    		datetime,
  @Conexion			bit,
  @SincroFinal			bit,
  @Sucursal			int,
  @UtilizarID			int,
  @UtilizarMovTipo    		char(20),
  @Ok				int		OUTPUT,
  @OkRef			varchar(255)	OUTPUT
AS BEGIN

  IF @Modulo = 'COMS'
  BEGIN
  
    --Kike Sierra: 2017-02-17: Procedimiento encargado de llevar el registro de las
    -- compras especiales.
    EXEC CUP_SPI_ComprasEspeciales_RegistroLog
      @Modulo,
      @ID,
      @Accion,
      @Base,
      @Estatus,
      @EstatusNuevo,
      @Mov,
      @MovTipo,
      @Usuario,
      @OK OUTPUT,
      @OkRef OUTPUT

   END

  RETURN
END