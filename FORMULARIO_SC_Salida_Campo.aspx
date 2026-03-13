<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CITRO - Formulario SC (Salida de Campo + Apoyo)</title>
    <link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans:wght@300;400;500;600;700&family=IBM+Plex+Mono:wght@400;500&display=swap" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@emailjs/browser@3/dist/email.min.js"></script>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'IBM Plex Sans', sans-serif;
            background: linear-gradient(135deg, #1A7A4A 0%, #2D9B5F 50%, #0A7A6E 100%);
            min-height: 100vh;
            padding: 20px;
            color: #162040;
        }

        .container {
            max-width: 1000px;
            margin: 0 auto;
            background: white;
            border-radius: 16px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            overflow: hidden;
        }

        .header {
            background: linear-gradient(140deg, #1B3A20 0%, #2D5C34 100%);
            padding: 40px 30px;
            color: white;
            text-align: center;
        }

        .header h1 {
            font-size: 2rem;
            margin-bottom: 10px;
            font-weight: 700;
        }

        .header p {
            font-size: 0.95rem;
            opacity: 0.9;
        }

        .header-logo {
            display: inline-block;
            width: 60px;
            height: 60px;
            background: rgba(76, 175, 80, 0.2);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            margin-bottom: 15px;
        }

        .content {
            padding: 40px;
        }

        .form-section {
            margin-bottom: 30px;
        }

        .section-title {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 2px solid #1A7A4A;
        }

        .section-number {
            background: #1A7A4A;
            color: white;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            flex-shrink: 0;
        }

        .section-title h3 {
            font-size: 1.2rem;
            color: #0D1F3C;
            flex: 1;
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
        }

        .form-grid.full {
            grid-template-columns: 1fr;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        .form-group.col-span-full {
            grid-column: 1 / -1;
        }

        label {
            font-weight: 600;
            color: #0D1F3C;
            margin-bottom: 8px;
            font-size: 0.95rem;
        }

        .required::after {
            content: " *";
            color: #C0392B;
        }

        input[type="text"],
        input[type="email"],
        input[type="date"],
        input[type="number"],
        select,
        textarea {
            padding: 12px 14px;
            border: 1px solid #C8D4E8;
            border-radius: 8px;
            font-family: 'IBM Plex Sans', sans-serif;
            font-size: 0.95rem;
            color: #162040;
            transition: all 0.3s;
        }

        input[type="text"]:focus,
        input[type="email"]:focus,
        input[type="date"]:focus,
        input[type="number"]:focus,
        select:focus,
        textarea:focus {
            outline: none;
            border-color: #1A7A4A;
            box-shadow: 0 0 0 3px rgba(26, 122, 74, 0.1);
            background: rgba(26, 122, 74, 0.02);
        }

        textarea {
            resize: vertical;
            min-height: 100px;
        }

        .error {
            border-color: #C0392B !important;
        }

        .error-message {
            color: #C0392B;
            font-size: 0.75rem;
            margin-top: 4px;
            display: none;
        }

        .error-message.show {
            display: block;
        }

        .hint {
            font-size: 0.8rem;
            color: #5A6880;
            margin-top: 4px;
            font-style: italic;
        }

        .gastos-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        .gastos-table tr {
            border-bottom: 1px solid #E8EDF5;
        }

        .gastos-table td {
            padding: 12px;
            text-align: left;
        }

        .gastos-table td:last-child {
            text-align: right;
        }

        .gastos-table input {
            width: 100%;
            padding: 8px;
        }

        .gastos-table tr:last-child {
            background: #F2F5FA;
            font-weight: bold;
            border-bottom: 2px solid #1A7A4A;
        }

        .total-display {
            background: linear-gradient(135deg, rgba(26, 122, 74, 0.1), rgba(26, 122, 74, 0.05));
            border: 2px solid #1A7A4A;
            border-radius: 8px;
            padding: 16px;
            text-align: center;
            font-size: 1.3rem;
            font-weight: 700;
            color: #1A7A4A;
            margin-top: 20px;
            font-family: 'IBM Plex Mono', monospace;
        }

        .buttons {
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
            margin-top: 40px;
            padding-top: 30px;
            border-top: 2px solid #E8EDF5;
        }

        button {
            padding: 12px 24px;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            font-size: 0.95rem;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .btn-primary {
            background: linear-gradient(135deg, #1B3A20 0%, #2D5C34 100%);
            color: white;
            flex: 1;
            min-width: 200px;
        }

        .btn-primary:hover {
            box-shadow: 0 8px 24px rgba(27, 58, 32, 0.3);
            transform: translateY(-2px);
        }

        .btn-secondary {
            background: #E8EDF5;
            color: #0D1F3C;
        }

        .btn-ghost {
            background: transparent;
            color: #1A7A4A;
            border: 2px solid #1A7A4A;
        }

        .toast {
            position: fixed;
            bottom: 20px;
            right: 20px;
            padding: 16px 24px;
            background: white;
            border-left: 4px solid #1A7A4A;
            border-radius: 8px;
            box-shadow: 0 8px 24px rgba(0,0,0,0.15);
            z-index: 9999;
            animation: slideIn 0.3s ease;
        }

        .toast.error {
            border-left-color: #C0392B;
        }

        @keyframes slideIn {
            from {
                transform: translateX(400px);
                opacity: 0;
            }
            to {
                transform: translateX(0);
                opacity: 1;
            }
        }

        .loading-overlay {
            position: fixed;
            inset: 0;
            background: rgba(0,0,0,0.5);
            display: none;
            align-items: center;
            justify-content: center;
            z-index: 10000;
        }

        .loading-overlay.show {
            display: flex;
        }

        .spinner {
            width: 50px;
            height: 50px;
            border: 4px solid rgba(255,255,255,0.2);
            border-top-color: white;
            border-radius: 50%;
            animation: spin 0.8s linear infinite;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        .config-section {
            background: #F2F5FA;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 20px;
        }

        .config-title {
            font-weight: 700;
            color: #0D1F3C;
            margin-bottom: 15px;
        }

        .success-modal {
            position: fixed;
            inset: 0;
            background: rgba(0,0,0,0.7);
            display: none;
            align-items: center;
            justify-content: center;
            z-index: 10000;
        }

        .success-modal.show {
            display: flex;
        }

        .modal-content {
            background: white;
            border-radius: 16px;
            padding: 40px;
            text-align: center;
            max-width: 500px;
        }

        .modal-icon {
            font-size: 3rem;
            margin-bottom: 20px;
        }

        .modal-title {
            font-size: 1.5rem;
            color: #0D1F3C;
            margin-bottom: 10px;
            font-weight: 700;
        }

        .modal-text {
            color: #5A6880;
            margin-bottom: 20px;
        }

        @media (max-width: 768px) {
            .form-grid {
                grid-template-columns: 1fr;
            }
            .buttons {
                flex-direction: column;
            }
            .header h1 {
                font-size: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <div class="header-logo">🌿</div>
            <h1>Salida de Campo + Apoyo Académico</h1>
            <p>Centro de Investigaciones Tropicales - Universidad Veracruzana</p>
        </div>

        <div class="content">
            <!-- CONFIGURACIÓN -->
            <div class="config-section">
                <div class="config-title">⚙️ Configuración de Envío</div>
                <div class="form-grid">
                    <div class="form-group">
                        <label for="recipientEmail" class="required">Correo de Destino</label>
                        <input type="email" id="recipientEmail" placeholder="ejemplo@uv.mx">
                    </div>
                    <div class="form-group">
                        <label for="senderEmail" class="required">Tu Correo</label>
                        <input type="email" id="senderEmail" placeholder="tu@uv.mx">
                    </div>
                </div>
            </div>

            <!-- SECCIÓN 1 -->
            <div class="form-section">
                <div class="section-title">
                    <div class="section-number">01</div>
                    <h3>Identificación del Solicitante</h3>
                </div>
                <div class="form-grid">
                    <div class="form-group">
                        <label for="apellidos" class="required">Apellido(s)</label>
                        <input type="text" id="apellidos" placeholder="García Morales">
                        <div class="error-message"></div>
                    </div>
                    <div class="form-group">
                        <label for="nombres" class="required">Nombre(s)</label>
                        <input type="text" id="nombres" placeholder="Alejandro">
                        <div class="error-message"></div>
                    </div>
                    <div class="form-group">
                        <label for="grado" class="required">Grado Académico</label>
                        <select id="grado">
                            <option value="">— Seleccione —</option>
                            <option>Lic.</option>
                            <option>Ing.</option>
                            <option>M.C.</option>
                            <option>Dr.</option>
                            <option>Dra.</option>
                            <option>Posdoctorante</option>
                        </select>
                        <div class="error-message"></div>
                    </div>
                    <div class="form-group">
                        <label for="matricula" class="required">Matrícula/N° Personal</label>
                        <input type="text" id="matricula" placeholder="S23XXXXXX">
                        <div class="error-message"></div>
                    </div>
                    <div class="form-group col-span-full">
                        <label for="correo" class="required">Correo Institucional</label>
                        <input type="email" id="correo" placeholder="s23xxx@estudiantes.uv.mx">
                        <div class="error-message"></div>
                    </div>
                </div>
            </div>

            <!-- SECCIÓN 2 -->
            <div class="form-section">
                <div class="section-title">
                    <div class="section-number">02</div>
                    <h3>Datos de la Salida de Campo</h3>
                </div>
                <div class="form-grid">
                    <div class="form-group col-span-full">
                        <label for="lugares" class="required">Lugar(es) de la Salida</label>
                        <textarea id="lugares" placeholder="Municipios, ejidos, coordenadas..."></textarea>
                        <div class="error-message"></div>
                    </div>
                    <div class="form-group col-span-full">
                        <label for="actividades" class="required">Actividades a Realizar</label>
                        <textarea id="actividades" placeholder="Muestreo, colecta, mediciones..."></textarea>
                        <div class="error-message"></div>
                    </div>
                    <div class="form-group">
                        <label for="fechaSalida" class="required">Fecha de Salida</label>
                        <input type="date" id="fechaSalida">
                        <div class="error-message"></div>
                    </div>
                    <div class="form-group">
                        <label for="fechaRegreso" class="required">Fecha de Regreso</label>
                        <input type="date" id="fechaRegreso">
                        <div class="error-message"></div>
                    </div>
                    <div class="form-group">
                        <label for="participantes">Número de Participantes</label>
                        <input type="number" id="participantes" placeholder="4" min="1">
                    </div>
                    <div class="form-group">
                        <label for="transporte">Vehículo/Transporte</label>
                        <input type="text" id="transporte" placeholder="Vehículo institucional">
                    </div>
                </div>
            </div>

            <!-- SECCIÓN 3 -->
            <div class="form-section">
                <div class="section-title">
                    <div class="section-number">03</div>
                    <h3>Recursos y Apoyo Solicitado</h3>
                </div>
                <div class="form-grid">
                    <div class="form-group col-span-full">
                        <label for="actividad" class="required">Actividad Académica</label>
                        <input type="text" id="actividad" placeholder="Nombre de la actividad...">
                        <div class="error-message"></div>
                    </div>
                    <div class="form-group">
                        <label for="tipoRecurso" class="required">Tipo de Recurso</label>
                        <select id="tipoRecurso">
                            <option value="">— Seleccione —</option>
                            <option>Viáticos y transporte</option>
                            <option>Materiales de laboratorio</option>
                            <option>Equipamiento científico</option>
                        </select>
                        <div class="error-message"></div>
                    </div>
                    <div class="form-group">
                        <label for="montoRecurso">Monto Estimado (MXN)</label>
                        <input type="number" id="montoRecurso" placeholder="0.00" min="0" step="0.01">
                    </div>
                    <div class="form-group col-span-full">
                        <label for="justificacion" class="required">Justificación Académica</label>
                        <textarea id="justificacion" placeholder="Justifique la necesidad..."></textarea>
                        <div class="error-message"></div>
                    </div>
                </div>
            </div>

            <!-- SECCIÓN 4: DESGLOSE DE GASTOS -->
            <div class="form-section">
                <div class="section-title">
                    <div class="section-number">04</div>
                    <h3>Desglose de Gastos Estimados</h3>
                </div>
                <table class="gastos-table">
                    <tr>
                        <td><strong>Concepto</strong></td>
                        <td style="width: 150px;"><strong>Monto (MXN)</strong></td>
                    </tr>
                    <tr>
                        <td>Peaje</td>
                        <td><input type="number" id="peaje" value="0" min="0" step="0.01" oninput="calcularTotal()"></td>
                    </tr>
                    <tr>
                        <td>Combustible</td>
                        <td><input type="number" id="combustible" value="0" min="0" step="0.01" oninput="calcularTotal()"></td>
                    </tr>
                    <tr>
                        <td>Hospedaje</td>
                        <td><input type="number" id="hospedaje" value="0" min="0" step="0.01" oninput="calcularTotal()"></td>
                    </tr>
                    <tr>
                        <td>Alimentos</td>
                        <td><input type="number" id="alimentos" value="0" min="0" step="0.01" oninput="calcularTotal()"></td>
                    </tr>
                    <tr>
                        <td>Materiales y Consumibles</td>
                        <td><input type="number" id="materiales" value="0" min="0" step="0.01" oninput="calcularTotal()"></td>
                    </tr>
                    <tr>
                        <td>Otros</td>
                        <td><input type="number" id="otros" value="0" min="0" step="0.01" oninput="calcularTotal()"></td>
                    </tr>
                    <tr>
                        <td><strong>TOTAL ESTIMADO</strong></td>
                        <td><strong id="total">$0.00</strong></td>
                    </tr>
                </table>
            </div>

            <!-- BOTONES -->
            <div class="buttons">
                <button type="button" class="btn-primary" onclick="submitForm()">
                    <span>📤</span> Generar PDF y Enviar
                </button>
                <button type="button" class="btn-secondary" onclick="resetForm()">
                    <span>↻</span> Limpiar
                </button>
                <button type="button" class="btn-ghost" onclick="downloadPDF()">
                    <span>📥</span> Solo PDF
                </button>
            </div>
        </div>
    </div>

    <!-- LOADING -->
    <div class="loading-overlay" id="loadingOverlay">
        <div>
            <div class="spinner"></div>
            <div style="color: white; margin-top: 20px; font-weight: 500;">Generando PDF...</div>
        </div>
    </div>

    <!-- MODAL ÉXITO -->
    <div class="success-modal" id="successModal">
        <div class="modal-content">
            <div class="modal-icon">✅</div>
            <div class="modal-title">¡Solicitud Enviada!</div>
            <div class="modal-text">
                Tu formulario ha sido enviado a: <strong id="sentEmail"></strong>
            </div>
            <button class="btn-primary" onclick="closeModal()" style="width: 100%;">
                Aceptar
            </button>
        </div>
    </div>

    <script>
        (function() {
            // ✅ CREDENCIALES CONFIGURADAS PARA CITRO
            emailjs.init("fl5frTANPYuqaW5-p");  // Public Key real
        })();

        const requiredFields = [
            'recipientEmail', 'senderEmail', 'apellidos', 'nombres', 'grado',
            'matricula', 'correo', 'lugares', 'actividades', 'fechaSalida',
            'fechaRegreso', 'actividad', 'tipoRecurso', 'justificacion'
        ];

        function validateEmail(email) {
            return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
        }

        function getFieldValue(id) {
            const el = document.getElementById(id);
            return el ? el.value.trim() : '';
        }

        function validateForm() {
            let valid = true;
            requiredFields.forEach(id => {
                const el = document.getElementById(id);
                const val = getFieldValue(id);
                if (!val) {
                    el.classList.add('error');
                    const err = el.nextElementSibling;
                    if (err && err.classList.contains('error-message')) {
                        err.textContent = 'Requerido';
                        err.classList.add('show');
                    }
                    valid = false;
                } else {
                    el.classList.remove('error');
                }
            });

            if (!validateEmail(getFieldValue('recipientEmail')) || !validateEmail(getFieldValue('senderEmail'))) {
                showToast('Correos inválidos', 'error');
                return false;
            }

            if (!valid) showToast('Completa todos los campos requeridos', 'error');
            return valid;
        }

        function calcularTotal() {
            const peaje = parseFloat(document.getElementById('peaje').value) || 0;
            const combustible = parseFloat(document.getElementById('combustible').value) || 0;
            const hospedaje = parseFloat(document.getElementById('hospedaje').value) || 0;
            const alimentos = parseFloat(document.getElementById('alimentos').value) || 0;
            const materiales = parseFloat(document.getElementById('materiales').value) || 0;
            const otros = parseFloat(document.getElementById('otros').value) || 0;

            const total = peaje + combustible + hospedaje + alimentos + materiales + otros;
            document.getElementById('total').textContent = '$' + total.toFixed(2);
        }

        function generatePDF() {
            const element = document.createElement('div');
            element.innerHTML = buildPrintHTML();
            const options = {
                margin: [15, 18, 15, 18],
                filename: `SC_${getFieldValue('matricula')}_${new Date().toISOString().split('T')[0]}.pdf`,
                image: { type: 'jpeg', quality: 0.98 },
                html2canvas: { scale: 2 },
                jsPDF: { unit: 'mm', format: 'a4', orientation: 'portrait' }
            };

            return new Promise((resolve, reject) => {
                html2pdf().set(options).from(element).save().then(() => resolve()).catch(reject);
            });
        }

        function buildPrintHTML() {
            const today = new Date().toLocaleDateString('es-MX', { year: 'numeric', month: 'long', day: 'numeric' });
            const total = (parseFloat(document.getElementById('peaje').value) || 0) +
                         (parseFloat(document.getElementById('combustible').value) || 0) +
                         (parseFloat(document.getElementById('hospedaje').value) || 0) +
                         (parseFloat(document.getElementById('alimentos').value) || 0) +
                         (parseFloat(document.getElementById('materiales').value) || 0) +
                         (parseFloat(document.getElementById('otros').value) || 0);

            return `
                <!DOCTYPE html>
                <html>
                <head>
                    <meta charset="utf-8">
                    <style>
                        body { font-family: "Times New Roman", serif; font-size: 12pt; line-height: 1.6; margin: 2cm; color: #111; }
                        p { margin-bottom: 8px; }
                        table { width: 100%; border-collapse: collapse; margin: 10px 0; }
                        th, td { border: 1px solid #333; padding: 6px; text-align: left; }
                        th { background: #f0f0f0; font-weight: bold; }
                        .hdr { text-align: center; border-bottom: 2px solid #1B3A20; padding-bottom: 12px; margin-bottom: 18px; }
                        .hdr-big { font-size: 15pt; font-weight: bold; color: #1B3A20; }
                    </style>
                </head>
                <body>
                    <div class="hdr">
                        <div style="font-size: 9pt; color: #5A6880;">Centro de Investigaciones Tropicales</div>
                        <div class="hdr-big">UNIVERSIDAD VERACRUZANA</div>
                        <div style="font-size: 9pt; color: #5A6880;">Xalapa, Veracruz — ${today}</div>
                    </div>

                    <p><strong>Asunto:</strong> Solicitud de Salida de Campo y Apoyo Académico</p>
                    <p>A quien corresponda:</p>
                    <p>Yo, <strong>${getFieldValue('nombres')} ${getFieldValue('apellidos')}</strong>, matrícula <strong>${getFieldValue('matricula')}</strong>, solicito autorización para la siguiente salida de campo:</p>

                    <h4>Detalles de la Salida</h4>
                    <p><strong>Lugar(es):</strong> ${getFieldValue('lugares')}</p>
                    <p><strong>Actividades:</strong> ${getFieldValue('actividades')}</p>
                    <p><strong>Fecha de Salida:</strong> ${getFieldValue('fechaSalida')}</p>
                    <p><strong>Fecha de Regreso:</strong> ${getFieldValue('fechaRegreso')}</p>
                    <p><strong>Participantes:</strong> ${getFieldValue('participantes') || 'No especificado'}</p>

                    <h4>Desglose de Gastos</h4>
                    <table>
                        <tr><th>Concepto</th><th style="width: 100px;">Monto (MXN)</th></tr>
                        <tr><td>Peaje</td><td>$${(parseFloat(document.getElementById('peaje').value) || 0).toFixed(2)}</td></tr>
                        <tr><td>Combustible</td><td>$${(parseFloat(document.getElementById('combustible').value) || 0).toFixed(2)}</td></tr>
                        <tr><td>Hospedaje</td><td>$${(parseFloat(document.getElementById('hospedaje').value) || 0).toFixed(2)}</td></tr>
                        <tr><td>Alimentos</td><td>$${(parseFloat(document.getElementById('alimentos').value) || 0).toFixed(2)}</td></tr>
                        <tr><td>Materiales</td><td>$${(parseFloat(document.getElementById('materiales').value) || 0).toFixed(2)}</td></tr>
                        <tr><td>Otros</td><td>$${(parseFloat(document.getElementById('otros').value) || 0).toFixed(2)}</td></tr>
                        <tr><th>TOTAL</th><th>$${total.toFixed(2)}</th></tr>
                    </table>

                    <h4>Justificación</h4>
                    <p>${getFieldValue('justificacion')}</p>

                    <p style="margin-top: 30px;">Atentamente,<br><strong>${getFieldValue('nombres')} ${getFieldValue('apellidos')}</strong></p>
                </body>
                </html>
            `;
        }

        function submitForm() {
            if (!validateForm()) return;

            showLoading(true);
            generatePDF()
                .then(() => {
                    const emailData = {
                        to_email: getFieldValue('recipientEmail'),
                        from_email: getFieldValue('senderEmail'),
                        apellidos: getFieldValue('apellidos'),
                        nombres: getFieldValue('nombres'),
                        total_gastos: document.getElementById('total').textContent
                    };

                    return emailjs.send('service_qy3lqek', 'template_pg_citro', emailData);
                })
                .then(() => {
                    showLoading(false);
                    document.getElementById('sentEmail').textContent = getFieldValue('recipientEmail');
                    document.getElementById('successModal').classList.add('show');
                })
                .catch(err => {
                    showLoading(false);
                    showToast('Error: ' + err.message, 'error');
                });
        }

        function downloadPDF() {
            if (!validateForm()) return;
            showLoading(true);
            generatePDF()
                .then(() => {
                    showLoading(false);
                    showToast('PDF descargado', 'success');
                })
                .catch(err => {
                    showLoading(false);
                    showToast('Error: ' + err.message, 'error');
                });
        }

        function resetForm() {
            document.querySelectorAll('input, select, textarea').forEach(el => {
                if (!el.id.includes('recipient') && !el.id.includes('sender')) {
                    el.value = '';
                }
            });
            document.querySelectorAll('.error').forEach(el => el.classList.remove('error'));
            document.getElementById('total').textContent = '$0.00';
        }

        function showLoading(show) {
            document.getElementById('loadingOverlay').classList.toggle('show', show);
        }

        function closeModal() {
            document.getElementById('successModal').classList.remove('show');
        }

        function showToast(msg, type = 'info') {
            const toast = document.createElement('div');
            toast.className = `toast ${type}`;
            toast.textContent = msg;
            document.body.appendChild(toast);
            setTimeout(() => toast.remove(), 4000);
        }

        document.addEventListener('DOMContentLoaded', function() {
            document.getElementById('fechaSalida').valueAsDate = new Date();
            document.getElementById('fechaRegreso').valueAsDate = new Date();
            calcularTotal();
        });
    </script>
</body>
</html>
