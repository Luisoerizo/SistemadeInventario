<?php 
require_once "../models/articulo.php";

$articulo = new Articulo();

//Obtener valores a través del formulario
$idarticulo=isset($_POST["idarticulo"])? limpiarCadena($_POST["idarticulo"]):"";
$idcategoria=isset($_POST["idcategoria"])? limpiarCadena($_POST["idcategoria"]):"";
$codigo=isset($_POST["codigo"])? limpiarCadena($_POST["codigo"]):"";
$nombre=isset($_POST["nombre"])? limpiarCadena($_POST["nombre"]):"";
$stock=isset($_POST["stock"])? limpiarCadena($_POST["stock"]):"";
$descripcion=isset($_POST["descripcion"])? limpiarCadena($_POST["descripcion"]):"";
$imagen=isset($_POST["imagen"])? limpiarCadena($_POST["imagen"]):"";


switch ($_GET["op"]){
	case 'guardaryeditar':
		if(!file_exists($_FILES['imagen']['tmp_name']) || !is_uploaded_file($_FILES['imagen']['tmp_name'])){
			$imagen =$_POST["imagenactual"];		//Si no suben nada y si no se encuentra nada cargado entonces se declara un valor vacío a imagen
		}
		else{ //si se sube un archivo entonces se procede a verificarlo
			$ext = explode(".",$_FILES['imagen']['tmp_name']); //obtener extensión de archivo después del punto
			if($_FILES['imagen']['type'] == "image/jpg" || $_FILES['imagen']['type'] == "image/jpeg"  ||
			$_FILES['imagen']['type'] == "image/png"){
				$imagen = round(microtime(true)).'.'.end($ext); //Se renombra la imagen para que no pueda ser repetida
				move_uploaded_file($_FILES['imagen']['tmp_name'],"../files/articulos/".$imagen); //donde se subirá el archivo
			}
		}
		if (empty($idarticulo)){
			$rspta=$articulo->insertar($idcategoria,$codigo,$nombre,$stock,$descripcion,$imagen);
			echo $rspta ? "Artículo registrado" : "El artículo no se pudo registrar";
		}
		else {
			$rspta=$articulo->editar($idarticulo,$idcategoria,$codigo,$nombre,$stock,$descripcion,$imagen);
			echo $rspta ? "Artículo actualizado" : "El artículo no se pudo actualizar";
		}
	break;

	case 'desactivar':
		$rspta=$articulo->desactivar($idarticulo);
 		echo $rspta ? "Artículo Desactivado" : "c";
 		break;
	break;

	case 'activar':
		$rspta=$articulo->activar($idarticulo);
 		echo $rspta ? "Artículo activado" : "El artículo no se pudo activar";
 		break;
	break;

	case 'mostrar':
		$rspta=$articulo->mostrar($idarticulo);
 		//Codificar el resultado utilizando json
 		echo json_encode($rspta);
 		break;
	break;

	case 'listar':
		$rspta=$articulo->listar();
 		//Vamos a declarar un array
 		$data= Array();
        //Validación de condición. Si está activo muestra un botón, si está desactivado muestra otro.
 		while ($reg=$rspta->fetch_object()){
 			$data[]=array(
 				"0"=>($reg->condicion)?'<button class="btn btn-warning" onclick="mostrar('.$reg->idarticulo.')"><i class="fa fa-pencil"></i></button>'.
 					' <button class="btn btn-danger" onclick="desactivar('.$reg->idarticulo.')"><i class="fa fa-close"></i></button>':
 					'<button class="btn btn-warning" onclick="mostrar('.$reg->idarticulo.')"><i class="fa fa-pencil"></i></button>'.
 					' <button class="btn btn-primary" onclick="activar('.$reg->idarticulo.')"><i class="fa fa-check"></i></button>',
				"1"=>$reg->nombre,
                "2"=>$reg->categoria,
 				"3"=>$reg->codigo,
                "4"=>$reg->stock,
 				"5"=>"<img src='../files/articulos/".$reg->imagen."' height='50px' width='50px' >",
 				"6"=>($reg->condicion)?'<span class="label bg-green">Activo</span>':
 				'<span class="label bg-red">Desactivado</span>'
 				);
 		}
 		$results = array(
 			"sEcho"=>1, //Información para el datatables
 			"iTotalRecords"=>count($data), //enviamos el total registros al datatable
 			"iTotalDisplayRecords"=>count($data), //enviamos el total registros a visualizar
 			"aaData"=>$data);
 		echo json_encode($results);

	break;
	
	case "selectCategoria":
		require_once "../models/categoria.php";
		$categoria = new Categoria();
		$rspta = $categoria->select();

			while($reg = $rspta->fetch_object()){
				echo '<option value='.$reg->idcategoria.'>'.$reg->nombre.'</option>';
			}
	break;
}
