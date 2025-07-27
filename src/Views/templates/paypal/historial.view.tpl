<h1>Historial de Transacciones</h1>

{% if transacciones is empty %}
  <p>No hay transacciones realizadas.</p>
{% else %}
  <table border="1" cellpadding="5" cellspacing="0">
    <thead>
      <tr>
        <th>ID</th>
        <th>Fecha</th>
        <th>Total</th>
        <th>Productos</th>
      </tr>
    </thead>
    <tbody>
      {% for trans in transacciones %}
      <tr>
        <td>{{ trans.transaccion_id }}</td>
        <td>{{ trans.fecha }}</td>
        <td>${{ trans.total }}</td>
        <td>
          <ul>
            {% for detalle in trans.detalles %}
              <li>{{ detalle.nombre }} - Cant: {{ detalle.cantidad }} - ${{ detalle.precio }}</li>
            {% endfor %}
          </ul>
        </td>
      </tr>
      {% endfor %}
    </tbody>
  </table>
{% endif %}
