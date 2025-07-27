<section class="depth-2 px-2 py-2">
    <h2>Mantenimiento de Videojuegos</h2>
</section>
<section class="WWList my-5">
    <table>
        <thead>
            <tr>
                <th>Código</th>
                <th>Título</th>
                <th>Descripción</th>
                <th>Precio</th>
                <th>Formato</th>
                <th>Estado</th>
                <th>Creado</th>
                <th>
                    <a href="index.php?page=Videojuegos-Videojuego&mode=INS&videojuegocod=">
                        Nuevo
                    </a>
                </th>
            </tr>
        </thead>
        <tbody>
            {{foreach videojuegos}}
            <tr>
                <td>{{videojuegocod}}</td>
                <td>{{titulo}}</td>
                <td>{{descripcion}}</td>
                <td>L {{precio}}</td>
                <td>{{formato}}</td>
                <td>{{videojuegoest}}</td>
                <td>{{creado_en}}</td>
                <td>
                    <a href="index.php?page=Videojuegos-Videojuego&mode=DSP&videojuegocod={{videojuegocod}}">
                        Ver
                    </a>
                    &nbsp;
                    <a href="index.php?page=Videojuegos-Videojuego&mode=UPD&videojuegocod={{videojuegocod}}">
                        Editar
                    </a>
                    &nbsp;
                    <a href="index.php?page=Videojuegos-Videojuego&mode=DEL&videojuegocod={{videojuegocod}}">
                        Eliminar
                    </a>
                </td>
            </tr>
            {{endfor videojuegos}}
        </tbody>
    </table>
</section>