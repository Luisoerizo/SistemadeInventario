<?php
ob_start();
session_start();
if(!isset($_SESSION["nombre"])){
  header("Location: login.html");
}
else{
      include_once 'header.php';
      if ($_SESSION['compras'] == 1) {
?>
<!--Contenido-->
      <!-- Content Wrapper. Contains page content -->
      <div class="content-wrapper">        
        <!-- Main content -->
        <section class="content">
            <div class="row">
              <div class="col-md-12">
                  <div class="box">
                    <div class="box-header with-border">
                          <h1 class="box-title"> Proveedores  <button class="btn btn-success" onclick="mostrarform(true)"
                           id="btnAgregar" name="btnAgregar"> Agregar  <i class="fa fa-plus-circle"></i></button></h1>
                        <div class="box-tools pull-right">
                        </div>
                    </div>
                    <!-- /.box-header -->
                    <!-- centro -->
                    <div class="panel-body table-responsive" id="listadoregistros">
                        <table id="tbllistado" name="tbllistado"class="table table-striped table-bordered table-condensed table-hover">
                          <thead>
                          <th>Opciones</th>
                          <th>Nombre</th>
                          <th>Documento</th>
                          <th>Número</th>
                          <th>Teléfono</th>
                          <th>Email</th>
                          </thead>
                          <tbody>
                             
                          </tbody>
                          <tfoot>
                          <th>Opciones</th>
                          <th>Nombre</th>
                          <th>Documento</th>
                          <th>Número</th>
                          <th>Teléfono</th>
                          <th>Email</th>
                          </tfoot>
                        </table>
                    </div>
                    <div class="panel-body" id="formularioregistros">
                        <form name="formulario" id="formulario"method="post">
                        <div class="form-group">
                            <input type="hidden" name="idpersona" id="idpersona" class="form-control">
                            </div>
                            <div class="form-group">
                            <input type="hidden" name="tipo_persona" id="tipo_persona" class="form-control" value="Proveedor">
                            </div>
                        <div class="form-group col-lg-6 col-md-6 col-sm-6 col-xs-12">
                              <label for="my-input">Nombre</label>
                              <input class="form-control" type="text" name="nombre" id="nombre" maxlenght="100" placeholder="Nombre del proveedor" required>
                            </div>
                            <div class="form-group col-lg-6 col-md-6 col-sm-6 col-xs-12">
                            <label for="my-input">Tipo de Documento</label>
                            <select name="tipo_documento" id="tipo_documento" class="form-control select-picker">
                                <option value="INE">INE</option>
                                <option value="CURP">CURP</option>
                                <option value="RFC">RFC</option>
                            </select>
                            </div>  
                            <div class="form-group col-lg-6 col-md-6 col-sm-6 col-xs-12">
                            <label>Número documento</label>
                            <input type="text" name="num_documento" id="num_documento" maxlength="20" placeholder="Número documento" class="form-control">
                            </div>
                            <div class="form-group col-lg-6 col-md-6 col-sm-6 col-xs-12">
                            <label>Dirección</label>
                            <input type="text" name="direccion" id="direccion" maxlength="70" placeholder="Dirección" class="form-control">
                            </div>
                            <div class="form-group col-lg-6 col-md-6 col-sm-6 col-xs-12">
                            <label>Teléfono</label>
                            <input type="tel" name="telefono" id="telefono" maxlength="10" placeholder="Número documento" class="form-control">
                            </div>
                            <div class="form-group col-lg-6 col-md-6 col-sm-6 col-xs-12">
                            <label>Email</label>
                            <input type="text" name="email" id="email" maxlength="50" placeholder="Número documento" class="form-control">
                            </div>


                            <div class="form-group col-lg-12 col-md-12 col-sm-12 col-xs-12">
                              <button class="btn btn-primary " type="submit" id="btnGuardar"><i class="fa fa-save"></i> Guardar</button>
                              <button class="btn btn-danger " onClick="cancelarform()" type="button"> <i class="fa fa-arrow-circle-left" aria-hidden="true"></i> Cancelar</button>

                            </div>
                        </form>
                    </div>
                    <!--Fin centro -->
                  </div><!-- /.box -->
              </div><!-- /.col -->
          </div><!-- /.row -->
      </section><!-- /.content -->

    </div><!-- /.content-wrapper -->
  <!--Fin-Contenido-->
<?php
}else {
  require 'noacceso.php';
}
include_once 'footer.php';
?>
<script type="text/javascript" src="scripts/proveedor.js"></script>
<?php
}