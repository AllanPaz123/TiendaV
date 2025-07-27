<section class="depth-2 px-2 py-2">
    <h2>Mantenimiento de Inventario</h2>
</section>
<section class="WWList my-5">
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Videojuego ID</th>
                <th>Stock</th>
                <th>Ubicación</th>
                <th>
                    <a href="index.php?page=Videojuegos-Inventario&mode=INS&inventarioid=">
                        Nuevo
                    </a>
                </th>
            </tr>
        </thead>
        <tbody>
            {{foreach inventario}}
            <tr>
                <td>{{inventarioid}}</td>
                <td>{{videojuegocod}}</td>
                <td>{{stock}}</td>
                <td>{{ubicacion}}</td>
                <td>
                    <a href="index.php?page=Videojuegos-Inventario&mode=DSP&inventarioid={{inventarioid}}">
                        Ver
                    </a>
                    &nbsp;
                    <a href="index.php?page=Videojuegos-Inventario&mode=UPD&inventarioid={{inventarioid}}">
                        Editar
                    </a>
                    &nbsp;
                    <a href="index.php?page=Videojuegos-Inventario&mode=DEL&inventarioid={{inventarioid}}">
                        Eliminar
                    </a>
                </td>
            </tr>
            {{endfor inventario}}
        </tbody>
    </table>
</section>
