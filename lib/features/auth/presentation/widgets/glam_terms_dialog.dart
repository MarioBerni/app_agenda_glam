import 'package:app_agenda_glam/core/theme/app_theme_constants.dart';
import 'package:flutter/material.dart';

/// Diálogo modal estilizado que muestra los términos y condiciones
/// con una interfaz coherente con el tema premium de la aplicación.
class GlamTermsDialog extends StatelessWidget {
  /// Callback que se ejecuta cuando se aceptan los términos
  final VoidCallback onAccept;

  /// Callback que se ejecuta cuando se cierra el diálogo sin aceptar
  final VoidCallback onClose;

  /// Constructor del diálogo de términos y condiciones
  const GlamTermsDialog({
    super.key,
    required this.onAccept,
    required this.onClose,
  });

  /// Método estático para mostrar el diálogo de términos y condiciones
  /// con una animación de deslizamiento desde abajo
  static Future<bool?> show(BuildContext context) async {
    return await showGeneralDialog<bool>(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Barrier',
      barrierColor: Colors.black.withValues(alpha: 0.5),
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (_, __, ___) => const SizedBox.shrink(), // No se usa
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        // Animación de deslizamiento desde abajo
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutQuint,
        );
        
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1), // Comienza desde abajo (y=1)
            end: Offset.zero, // Termina en la posición final (y=0)
          ).animate(curvedAnimation),
          child: FadeTransition(
            opacity: animation,
            child: GlamTermsDialog(
              onAccept: () {
                Navigator.of(context).pop(true);
              },
              onClose: () {
                Navigator.of(context).pop(false);
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final dialogWidth = screenSize.width * 0.85;
    final dialogHeight = screenSize.height * 0.7;

    // Usando un enfoque diferente para el diálogo para evitar el problema de superposición
    return AlertDialog(
      backgroundColor: kSurfaceColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      contentPadding: EdgeInsets.zero,
      content: Container(
        width: dialogWidth,
        height: dialogHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: kAccentColor.withValues(alpha: 0.3),
            width: 1.5,
          ),
        ),
        child: Column(
          children: [
            // Encabezado
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    kPrimaryColor,
                    kPrimaryColorDark,
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Stack(
                children: [
                  // Título centrado
                  Center(
                    child: Text(
                      'Términos y Condiciones',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // Botón de cierre
                  Positioned(
                    right: 8,
                    top: 0,
                    child: IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white70,
                      ),
                      onPressed: onClose,
                      splashRadius: 24,
                    ),
                  ),
                ],
              ),
            ),
            
            // Contenido con scroll
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: _buildTermsContent(context),
              ),
            ),
            
            // Pie con botones usando un enfoque diferente
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 16,
              ),
              decoration: BoxDecoration(
                color: kSurfaceColor.withValues(alpha: 0.9),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Botón de cerrar
                  TextButton.icon(
                    onPressed: onClose,
                    icon: const Icon(Icons.cancel_outlined, size: 20),
                    label: const Text('Cerrar'),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white70,
                    ),
                  ),
                  // Botón de aceptar con estilo diferente
                  ElevatedButton.icon(
                    onPressed: onAccept,
                    icon: const Icon(Icons.check_circle_outline, size: 20),
                    label: const Text('Aceptar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kAccentColor,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Construye el contenido de los términos y condiciones
  Widget _buildTermsContent(BuildContext context) {
    // Contenido temporal para los términos y condiciones
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('1. Introducción'),
        _buildParagraph(
          'Bienvenido a Agenda Glam. Estos Términos y Condiciones rigen el uso de nuestra aplicación móvil, sitio web y servicios relacionados (colectivamente, los "Servicios"). Al acceder o utilizar nuestros Servicios, usted acepta estar sujeto a estos Términos. Si no está de acuerdo con estos Términos, por favor no utilice nuestros Servicios.',
        ),
        
        _buildSectionTitle('2. Definiciones'),
        _buildParagraph(
          '"Usuario" se refiere a cualquier persona que acceda o utilice los Servicios, ya sea como cliente, proveedor de servicios o empleado.',
        ),
        _buildParagraph(
          '"Contenido" se refiere a toda la información y datos disponibles a través de los Servicios, incluyendo texto, imágenes, videos, audio, y otros materiales.',
        ),
        
        _buildSectionTitle('3. Registro y Cuentas'),
        _buildParagraph(
          'Para utilizar ciertas funciones de nuestros Servicios, es posible que deba registrarse y crear una cuenta. Usted es responsable de mantener la confidencialidad de su información de cuenta y contraseña, y de restringir el acceso a su dispositivo. Usted acepta la responsabilidad por todas las actividades que ocurran bajo su cuenta.',
        ),
        _buildParagraph(
          'Usted debe proporcionar información precisa, actual y completa durante el proceso de registro y mantener y actualizar dicha información para mantenerla precisa, actual y completa.',
        ),
        
        _buildSectionTitle('4. Servicios y Reservas'),
        _buildParagraph(
          'Agenda Glam facilita la conexión entre clientes y proveedores de servicios de estética masculina. No somos proveedores directos de servicios de estética y no somos responsables de la calidad, seguridad, legalidad o cualquier otro aspecto de los servicios proporcionados por terceros a través de nuestra plataforma.',
        ),
        _buildParagraph(
          'Las reservas realizadas a través de nuestros Servicios están sujetas a la disponibilidad y confirmación del proveedor de servicios. Nos reservamos el derecho de rechazar o cancelar reservas a nuestra discreción.',
        ),
        
        _buildSectionTitle('5. Política de Cancelación'),
        _buildParagraph(
          'Las cancelaciones están sujetas a la política de cada proveedor de servicios individual. Algunos proveedores pueden cobrar tarifas de cancelación por citas canceladas con menos de 24 horas de anticipación. Por favor, consulte la política de cancelación del proveedor antes de hacer una reserva.',
        ),
        
        _buildSectionTitle('6. Privacidad'),
        _buildParagraph(
          'Su privacidad es importante para nosotros. Nuestra Política de Privacidad explica cómo recopilamos, usamos y protegemos su información personal. Al utilizar nuestros Servicios, usted acepta nuestras prácticas de recopilación y uso de datos como se describe en nuestra Política de Privacidad.',
        ),
        
        _buildSectionTitle('7. Propiedad Intelectual'),
        _buildParagraph(
          'Los Servicios y todo el contenido y materiales disponibles a través de los Servicios, incluyendo pero no limitado a texto, gráficos, logotipos, iconos, imágenes, clips de audio, descargas digitales, y software, son propiedad de Agenda Glam o sus licenciantes y están protegidos por leyes de derechos de autor, marcas registradas y otras leyes de propiedad intelectual.',
        ),
        
        _buildSectionTitle('8. Limitación de Responsabilidad'),
        _buildParagraph(
          'En la máxima medida permitida por la ley aplicable, Agenda Glam no será responsable por daños indirectos, incidentales, especiales, consecuentes o punitivos, o cualquier pérdida de beneficios o ingresos, ya sea incurrida directa o indirectamente, o cualquier pérdida de datos, uso, buena voluntad, u otras pérdidas intangibles.',
        ),
        
        _buildSectionTitle('9. Cambios en los Términos'),
        _buildParagraph(
          'Nos reservamos el derecho de modificar estos Términos en cualquier momento a nuestra sola discreción. Si realizamos cambios, publicaremos los Términos actualizados y actualizaremos la fecha de "Última actualización" en la parte superior de estos Términos. Su uso continuado de los Servicios después de que tales cambios entren en vigor constituye su aceptación de los nuevos Términos.',
        ),
        
        _buildSectionTitle('10. Ley Aplicable'),
        _buildParagraph(
          'Estos Términos se regirán e interpretarán de acuerdo con las leyes de Uruguay, sin dar efecto a ningún principio de conflictos de leyes.',
        ),
        
        const SizedBox(height: 24),
        Text(
          'Última actualización: 23 de mayo de 2025',
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withValues(alpha: 0.7),
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }

  /// Widget para títulos de sección
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: kAccentColor,
        ),
      ),
    );
  }

  /// Widget para párrafos de texto
  Widget _buildParagraph(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          height: 1.5,
          color: Colors.white.withValues(alpha: 0.9),
        ),
      ),
    );
  }
}
