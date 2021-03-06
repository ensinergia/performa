# encoding:utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

Position.create(:name => 'user', :role_equivalence => Role.user)
Position.create(:name => 'admin', :role_equivalence => Role.admin)
Position.create(:name => 'owner', :role_equivalence => Role.super_admin)

# Predefined Contextual Legends

ContextualLegend.create(:content => "**Visión**

Para asegurar una correcta definición de la visión, recomendamos tomar en consideración lo siguiente:

 1. La Visión debe expresar un sueño; un estado ideal.  
 2. Inspira a entrar en acción y define la dirección a seguir.
 3. Breve, clara y precisa.
 4. Positiva y con un horizonte de tiempo establecido.
 5. Compartida por la organización.

**Últimas Actividades**

Las personas seleccionadas recibirán un correo electrónico cuando la Visión haya sido agregada. También recibirán una notificación cada vez que un nuevo comentario haya sido agregado.", 
:url => "/creed/visions/new")

ContextualLegend.create(:content => "La definición del Planteamiento Estratégico arranca con una dirección clara y precisa del rumbo estratégico de la Organización. Esta dirección se plantea a través de la Visión.
  
La **Visión** describe lo que la organización espera alcanzar dentro de un período de tiempo determinado.  Un enunciado breve que expresa el estado futuro deseado de una manera realista y posible de alcanzar.", :url => "/creed/visions#empty")

ContextualLegend.create(:content => "**Visión**

Para asegurar una correcta definición de la visión es necesario validar que todos los atributos de la visión hayas sido tomados en consideración.  Agrega un comentario con tu evaluación de la visión. 

**Notificación de la Visión**

Estas personas están subscritas a recibir notificaciones por correo electrónico cuando nuevos comentarios sean agregados en la visión.", :url => "/creed/visions")

ContextualLegend.create(:content => "**Visión**

Tú opinión es importante. 
Para validar el ejercicio de visión, es necesario que emitas un comentario tomando en consideración los atributos de la visión: 

 - La Visión debe expresar un sueño; un estado ideal.  
 - Inspira a entrar en acción y define la dirección a seguir.
 - Breve, clara y precisa.
 - Positiva y con un horizonte de tiempo establecido.
 - Compartida por la organización.

**Notificación de la Visión**

Estas personas están subscritas a recibir notificaciones por correo electrónico cuando nuevos comentarios sean agregados en la visión.", :url => "/creed/visions#comments_form")

ContextualLegend.create(:content => "**Visión**

Tú opinión es importante. 
Para visualizar todos comentarios realizados a la visión, haz click en Ver comentarios. También puedes emitir un comentario haciendo click en Comentar.

**Notificación de la Visión**

Estas personas están subscritas a recibir notificaciones por correo electrónico cuando nuevos comentarios sean agregados en la visión.", :url => "/creed/visions#comments_form_pre")

ContextualLegend.create(:content => "El éxito en la definición de un planteamiento estratégico depende del grado de entendimiento de la situación actual de la Organización. Esta evaluación se lleva a cabo mediante el **Análisis FODA** por sus siglas, Fortalezas, Oportunidades, Debilidades y Amenazas. 

El FODA se compone de dos elementos: 

 - **Análisis Interno:** describe las características internas y los factores controlables de la organización : *Fortalezas y Debilidades.* 
 - **Análisis Externo:** evalúa la situación competitiva factores no controlables de la organización: *Oportunidades y Amenazas.*

Empecemos con el Análisis Interno: Agregar Fortalezas y Debilidades.", :url => "/swot/analyses")

ContextualLegend.create(:content => "**Análisis Externo**

Evalúa la situación competitiva factores no controlables de la organización: Oportunidades y Amenazas.

**Oportunidades:** son aquellos factores que resultan positivos, favorables, explotables, que se deben descubrir en el entorno en el que actúa la organización, y que permiten obtener ventajas competitivas.

**Amenazas:** son aquellas situaciones que provienen del entorno y que pueden llegar a atentar incluso contra la permanencia de la organización.

Para agregar una Oportunidad o Amenaza, escríbela en el cuadro de texto y haz clic en el botón  de Agregar. 

**Notificaciones**
Las personas que selecciones recibirán un correo electrónico cuando una fortaleza o debilidad haya sido agregada. También recibirán una notificación cuando  nuevos comentarios sean agregados.
 ", :url => "/swot/analyses/external")

ContextualLegend.create(:content => "**Análisis Interno**

Describe las características internas y los factores controlables de la organización : Fortalezas y Debilidades. 

**Fortalezas:** son las capacidades especiales con que cuenta la organización, y por los que cuenta con una posición privilegiada frente a la competencia. Representan aquellos recursos que controlables, capacidades y habilidades que se poseen, actividades que se desarrollan positivamente, etc.

**Debilidades:** son aquellos factores que provocan una posición desfavorable frente a la competencia. Aquellos recursos de los que se carece, habilidades que no se poseen, actividades que no se desarrollan eficientemente, etc.

Para agregar una Fortaleza o Debilidad, escríbela en el cuadro de texto y haz clic en el botón  de Agregar. 

**Notificaciones**
Las personas que selecciones recibirán un correo electrónico cuando una fortaleza o debilidad haya sido agregada. También recibirán una notificación cuando  nuevos comentarios sean agregados.", :url => "/swot/analyses/internal")

ContextualLegend.create(:content => "**Análisis Externo**

Evalúa la situación competitiva factores no controlables de la organización: Oportunidades y Amenazas.

**Oportunidades:** son aquellos factores que resultan positivos, favorables, explotables, que se deben descubrir en el entorno en el que actúa la organización, y que permiten obtener ventajas competitivas.

**Amenazas:** son aquellas situaciones que provienen del entorno y que pueden llegar a atentar incluso contra la permanencia de la organización.

Para agregar un comentario acerca de una Oportunidad o Amenaza, escríbela en el cuadro de texto y haz clic en el botón  de Agregar. 

**Notificaciones**

Las personas que selecciones recibirán un correo electrónico cuando una fortaleza o debilidad haya sido agregada. También recibirán una notificación cuando  nuevos comentarios sean agregados.", :url => "/swot/analyses/:analysis_id/comments")

ContextualLegend.create(:content => "Una vez que se tiene un entendimiento profundo sobre la situación actual, habiendo detectado las ventajas y limitantes de la organización, es necesario determinar las áreas de acción prioritarias mediante la definición de líneas estratégicas que asegurarán el enfoque en el planteamiento estratégico. 

Las **Líneas Estratégicas** constituyen lineamientos generales y el camino que deberá seguirse para alcanzar los objetivos en un plazo determinado.

Se pueden diseñar una o varias estrategias que reflejen el quehacer sustantivo de la organización. 

Para agregar una línea estratégica haz clic en el botón de Agregar.", :url => "/strategic_lines")

ContextualLegend.create(:content => "**Líneas Estratégicas**

Las Líneas Estratégicas constituyen lineamientos generales y el camino que deberá seguirse para alcanzar los objetivos en un plazo determinado.

Las líneas estratégicas deben estar alineadas a la Visión y responder a las necesidades detectadas en el Análisis FODA. 

La sintaxis recomendada para la redacción de líneas estratégicas es la siguiente:
VERBO + QUE HACER / COMO + PARA QUIENES / CONDICIONES
             
Para agregar una Línea Estratégica, escríbela en el cuadro de texto y haz clic en el botón  de Guardar. 

**Notificaciones**

Las personas que selecciones recibirán un correo electrónico cuando una línea estratégica haya sido agregada. También recibirán una notificación cuando  nuevos comentarios sean agregados.", :url => "/strategic_lines/new")

ContextualLegend.create(:content => "**Líneas Estratégicas**

Las Líneas Estratégicas constituyen lineamientos generales y el camino que deberá seguirse para alcanzar los objetivos en un plazo determinado.

Las líneas estratégicas deben estar alineadas a la Visión y responder a las necesidades detectadas en el Análisis FODA. 

La sintaxis recomendada para la redacción de líneas estratégicas es la siguiente:
VERBO + QUE HACER / COMO + PARA QUIENES / CONDICIONES

Para agregar un comentario acerca de una Línea Estratégica, escríbela en el cuadro de texto y haz clic en el botón  de Comentar. 

**Notificaciones**

Las personas que selecciones recibirán un correo electrónico cuando una fortaleza o debilidad haya sido agregada. También recibirán una notificación cuando  nuevos comentarios sean agregados.", :url => "/strategic_lines#non_empty")


ContextualLegend.create(:content => "Habiendo definido las prioridades y áreas de enfoque en las líneas estratégicas, procedemos a la definición de los Objetivos Estratégicos. 

Los **Objetivos Estratégicos** son enunciados breves que enfatizan una idea principal o área de logro. Se definen tomando en cuenta los retos, las necesidades, la innovación y su contribución a la Visión. 

Puntualizan los resultados esperados de la organización y establecen las bases para la medición de los logros esperados. 

Para agregar un Objetivo Estratégico haz clic en el botón de Agregar.", :url => "/strategic_objectives")

ContextualLegend.create(:content => "**Objetivos Estratégicos**

Las Objetivos Estratégicos deben de expresar de forma clara y precisa: **¿Qué queremos lograr?**

Para la definición de Objetivos, es necesario tomar en consideración los siguientes atributos:

 1. Estar orientados a resultados
 2. Enfatizar la idea de logro
 3. Ser medibles
 4. Ser permanentes en un mediano plazo
 5. Comenzar siempre con verbo

La sintaxis recomendada para la redacción de Objetivos Estratégicos es la siguiente:

***Verbo + Elemento a Medir + Enfoque/Área de Énfasis***


Los verbos sugeridos son: Incrementar, Reducir o Mantener (con sus respectivos sinónimos).

Para Editar un Objetivo Estratégico, haz clic en el ícono editar.

Para agregar un Comentario acerca de un Objetivo Estratégico, haz clic en Comentar.", :url => "/strategic_objectives#non_empty")

ContextualLegend.create(:content => "Las Objetivos Estratégicos deben de expresar de forma clara y precisa: **¿Qué queremos lograr?**

Para la definición de Objetivos, es necesario tomar en consideración los siguientes atributos:

 1. Estar orientados a resultados
 2. Enfatizar la idea de logro
 3. Ser medibles
 4. Ser permanentes en un mediano plazo
 5. Comenzar siempre con verbo

La sintaxis recomendada para la redacción de Objetivos Estratégicos es la siguiente:

***Verbo + Elemento a Medir + Enfoque/Área de Análisis***

Los verbos sugeridos son: Incrementar, Reducir o Mantener (con sus respectivos sinónimos).

**Alineación a Líneas Estratégicas**

Seleccionar las líneas estratégicas a las que el Objetivo contribuye en el logro o cumplimiento de las mismas.

Para agregar un Objetivo Estratégico, escríbelo en el cuadro de texto y al finalizar haz clic en el botón  de Guardar. 

**Notificaciones**

Las personas que selecciones recibirán un correo electrónico cuando un objetivo estratégico haya sido agregado. También recibirán una notificación cuando  nuevos comentarios sean agregados.
 
 ", :url => "/strategic_objectives/new")

ContextualLegend.create(:content => "Para agregar Áreas haz clic en el botón de Agregar.", :url => "/people#empty")

ContextualLegend.create(:content => "Sin definir aún", :url => "/people/admin")


ContextualLegend.create(:content => "**Áreas**

Para crear un área nueva, solo haz clic en el botón de Agregar Área. Solo será necesario escribir el nombre del área. En el campo de texto. Una vez creada podrás hacer cualquier modificación y agregar personas. 

**Agregar Personas**

Para agregar una nueva persona haz clic en el botón de Agregar una Persona. Solo es necesario llenar los campos de nombre, apellido y correo electrónico. Al hacer clic en Agregar Persona automáticamente el usuario recibirá una notificación de su invitación al sistema y una liga donde podrá agregar su información.", :url => "/people#non_empty")

ContextualLegend.create(:content => "**Áreas**

Para crear un área nueva, solo haz clic en el botón de Agregar Área. Solo será necesario escribir el nombre del área. En el campo de texto. Una vez creada el área es necesario definir las funciones sustantivas de la misma. 

**Agregar Funciones** 

Para agregar Funciones haz clic en el botón de Agregar Función. Solo es necesario redactar la función en el  campo de texto y al finalizar hacer clic en Agregar.

Para hacer cualquier modificación en las funciones solo es necesario hacer clic en el ícono de la pluma.", :url => "/areas/new")

# TODO - TOADD:  6,7, 11, 13 (ajax views and member views); 20