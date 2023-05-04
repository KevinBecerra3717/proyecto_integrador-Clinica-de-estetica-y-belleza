<?php
	$inicio = ($pagina>0) ? (($pagina * $registros)-$registros) : 0;
	$tabla="";

	$campos="product.product_id,product.product_codigo,product.product_name,product.product_sale_price,product.product_stock,product.product_image,product.categoria_id,product.us_id,categoria.categoria_id,categoria.categoria_nombre,usuarios.us_id,usuarios.us_nombre,usuarios.us_apellido";

	if(isset($busqueda) && $busqueda!=""){

		$consulta_datos="SELECT $campos FROM product INNER JOIN categoria ON product.categoria_id=categoria.categoria_id INNER JOIN usuarios ON product.us_id=usuarios.us_id WHERE product.product_codigo LIKE '%$busqueda%' OR product.product_name LIKE '%$busqueda%' ORDER BY product.product_name ASC LIMIT $inicio,$registros";

		$consulta_total="SELECT COUNT(product_id) FROM product WHERE product_codigo LIKE '%$busqueda%' OR product_name LIKE '%$busqueda%'";

	}elseif($categoria_id>0){

		$consulta_datos="SELECT $campos FROM product INNER JOIN categoria ON product.categoria_id=categoria.categoria_id INNER JOIN usuarios ON product.us_id=usuarios.us_id WHERE product.categoria_id='$categoria_id' ORDER BY product.product_name ASC LIMIT $inicio,$registros";

		$consulta_total="SELECT COUNT(product_id) FROM product WHERE categoria_id='$categoria_id'";

	}else{

		$consulta_datos="SELECT $campos FROM product INNER JOIN categoria ON product.categoria_id=categoria.categoria_id INNER JOIN usuarios ON product.us_id=usuarios.us_id ORDER BY product.product_name ASC LIMIT $inicio,$registros";

		$consulta_total="SELECT COUNT(product_id) FROM product";

	}

	$conexion=conexion();

	$datos = $conexion->query($consulta_datos);
	$datos = $datos->fetchAll();

	$total = $conexion->query($consulta_total);
	$total = (int) $total->fetchColumn();

	$Npaginas =ceil($total/$registros);

	if($total>=1 && $pagina<=$Npaginas){
		$contador=$inicio+1;
		$pag_inicio=$inicio+1;
		foreach($datos as $rows){
			$tabla.='
				<article class="media">
			        <figure class="media-left">
			            <p class="image is-64x64">';
			            if(is_file("./img/producto/".$rows['producto_foto'])){
			            	$tabla.='<img src="./img/producto/'.$rows['producto_foto'].'">';
			            }else{
			            	$tabla.='<img src="./img/producto.png">';
			            }
			   $tabla.='</p>
			        </figure>
			        <div class="media-content">
			            <div class="content">
			              <p>
			                <strong>'.$contador.' - '.$rows['producto_nombre'].'</strong><br>
			                <strong>CODIGO:</strong> '.$rows['producto_codigo'].', <strong>PRECIO:</strong> $'.$rows['producto_precio'].', <strong>STOCK:</strong> '.$rows['producto_stock'].', <strong>CATEGORIA:</strong> '.$rows['categoria_nombre'].', <strong>REGISTRADO POR:</strong> '.$rows['usuario_nombre'].' '.$rows['usuario_apellido'].'
			              </p>
			            </div>
			            <div class="has-text-right">
			                <a href="index.php?vista=product_img&product_id_up='.$rows['producto_id'].'" class="button is-link is-rounded is-small">Imagen</a>
			                <a href="index.php?vista=product_update&product_id_up='.$rows['producto_id'].'" class="button is-success is-rounded is-small">Actualizar</a>
			                <a href="'.$url.$pagina.'&product_id_del='.$rows['producto_id'].'" class="button is-danger is-rounded is-small">Eliminar</a>
			            </div>
			        </div>
			    </article>

			    <hr>
            ';
            $contador++;
		}
		$pag_final=$contador-1;
	}else{
		if($total>=1){
			$tabla.='
				<p class="has-text-centered" >
					<a href="'.$url.'1" class="button is-link is-rounded is-small mt-4 mb-4">
						Haga clic acá para recargar el listado
					</a>
				</p>
			';
		}else{
			$tabla.='
				<p class="has-text-centered" >No hay registros en el sistema</p>
			';
		}
	}

	if($total>0 && $pagina<=$Npaginas){
		$tabla.='<p class="has-text-right">Mostrando productos <strong>'.$pag_inicio.'</strong> al <strong>'.$pag_final.'</strong> de un <strong>total de '.$total.'</strong></p>';
	}

	$conexion=null;
	echo $tabla;

	if($total>=1 && $pagina<=$Npaginas){
		echo paginador_tablas($pagina,$Npaginas,$url,7);
	}