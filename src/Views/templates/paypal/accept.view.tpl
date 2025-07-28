<section class="container-l">
  <section class="depth-4">
    <h1>Orden Aceptada</h1>
  </section>

  <div class="success-box">
    <p><strong>¡Gracias por tu compra!</strong></p>
    <p>Tu orden ha sido procesada exitosamente a través de PayPal.</p>
    <p>Puedes revisar el detalle completo en tu <a href="index.php?page=Checkout_Historial">historial de compras</a>.</p>
  </div>

  {{if orderjson}}
  <div class="debug-box" style="margin-top: 2rem;">
    <h4>Detalle de la respuesta PayPal (JSON):</h4>
    <pre style="font-size: 0.9rem; background-color: #f5f5f5; padding: 1rem;">{{orderjson}}</pre>
  </div>
  {{endif}}

  <div style="margin-top: 1rem;">
    <a href="index.php" class="btn">Volver al Inicio</a>
  </div>
</section>

<!--<h1>Orden Aceptada</h1>
<hr/>
<pre>
{{orderjson}}
</pre>>-->





