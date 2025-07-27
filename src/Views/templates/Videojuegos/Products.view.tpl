<section class="depth-2 px-2 py-2">
    <h2>Mantenimiento de Productos</h2>
</section>
<section class="WWList my-5">
    <table>
        <thead>
            <tr>
                <th>Código</th>
                <th>Videojuego</th>
                <th>Descripción</th>
                <th>Precio</th>
                <th>Stock</th>
                <th>Imagen</th>
                <th>Estado</th>
                <th>
                    <a href="index.php?page=Videojuegos-Product&mode=INS&productId=">
                        Nuevo
                    </a>
                </th>
            </tr>
        </thead>
        <tbody>
            {{foreach productos}}
            <tr>
                <td>{{productId}}</td>
                <td>{{productName}}</td>
                <td>{{productDescription}}</td>
                <td>L {{productPrice}}</td>
                <td>{{productStock}}</td>
                <td><img src="{{productImgUrl}}" alt="{{productName}}" width="50"></td>
                <td>{{productStatus}}</td>
                <td>
                    <a href="index.php?page=Videojuegos-Product&mode=DSP&productId={{productId}}">
                        Ver
                    </a>
                    &nbsp;
                    <a href="index.php?page=Videojuegos-Product&mode=UPD&productId={{productId}}">
                        Editar
                    </a>
                    &nbsp;
                    <a href="index.php?page=Videojuegos-Product&mode=DEL&productId={{productId}}">
                        Eliminar
                    </a>
                </td>
            </tr>
            {{endfor productos}}
        </tbody>
    </table>
     <div style="margin-top: 20px;">
        <a href="index.php" class="btn btn-primary">Regresar al inicio</a>
    </div>
</section>