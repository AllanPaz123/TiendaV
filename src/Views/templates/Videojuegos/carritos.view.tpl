<section class="depth-2 px-2 py-2">
    <h2>Mantenimiento de Carrito</h2>
</section>
<section class="WWList my-4">
    <table>
        <thead>
            <tr>
                <th>Id</th>
                <th>Usuario</th>
                <th>Videojuego</th>
                <th>Cantidad</th>
                <th>Tipo Entrega</th>
                <th>Agregado En</th>
                <th>
                    <a href="index.php?page=Videojuegos-Carrito&mode=INS&id=">
                        Nuevo
                    </a>
                </th>
            </tr>
        </thead>
        <tbody>
            {{foreach carritos}}
            <tr>
                <td>{{carritoid}}</td>
                <td>{{usercod}}</td>
                <td>{{videojuegocod}}</td>
                <td>{{cantidad}}</td>
                <td>{{tipo_entrega}}</td>
                <td>{{agregado_en}}</td>
                <td>
                    <a href="index.php?page=Videojuegos-Carrito&mode=DSP&id={{carritoid}}">
                        Ver
                    </a>
                    &nbsp;
                    <a href="index.php?page=Videojuegos-Carrito&mode=UPD&id={{carritoid}}">
                        Editar
                    </a>
                    &nbsp;
                    <a href="index.php?page=Videojuegos-Carrito&mode=DEL&id={{carritoid}}">
                        Eliminar
                    </a>
                </td>
            </tr>
            {{endfor carritos}}
        </tbody>
    </table>
</section>
