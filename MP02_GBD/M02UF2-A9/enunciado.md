# M02UF2-A9 - habitatge

## Nom de la base de dades: habitatge

## Nota final: 7/10

## Data de publicació: 02.04.2024

## Data d'entrega: 19.04.2024

## Enunciat:

Habitatge

Volem crear una BBDD de nom `habitatge` per a la venda i lloguer de vivendes.

La nostra base de dades estarà centrada en els municipis de Catalunya, però hauria de poder funcionar per a qualsevol municipi de la resta de l'Estat. 
De cada vivenda, que tindrà un identificador únic, ens interessarà conèixer quants dormitoris i banys té, la superfície de vivenda i la de terrasses (si en té), en quin any va ser construida, el seu estat de conservació (nova, reformada o cal reformar), el seu preu de venda i si està disponible per a llogar, una petita descripció sobre la vivienda (màxim 140 caràcters) i la darrera data en que s'han actualitzat les dades. 
Les vivendes les classificarem segons siguin unitats independents (casa) o de molts veïns (pis). 
Cada casa, pot ser de tipus: Aïllada, Adosada, Finca rústica, Masia o Castell. 
De les cases a més de les característiques de tots els habitatges, també voldrem saber el tipus, número de plantes o nivells en que està edificada i les superfícies de garatge i jardí, que en cas de no tenir-ne seran NULL. 
Cada pis, pot ser de tipus: Pis (a nivell genèric), Àtic, Dúplex, Estudi o Loft. 
Dels pisos, a més de les característiques de tots els habitatges, també voldrem saber el tipus, i el número de planta en la que es troba, sent 0 la planta baixa.
 Les vivendes, en general, també dispossaran de determinades propietats o característiques, de moment ens interessarà saber si un habitatge disposa de: Aire condicionat, Ascensor, Calefacció, Mobles, Parquing, Piscina, Traster i Xemeneia. En un futur ens podria interessar ampliar aquesta llista. Un altre element relacionat amb cada habitatge serà el seu Certificat Energètic. 
Les vivendes que el tinguin hauran de saber quin és el seu consum i les seves emissions. Aquests valors tenen una etiqueta que els classifica amb les lletres A fins la G (de més a menys eficiència). https://icaen.gencat.cat/ca/energia/usos_energia/edificis/certificacio/informacio_ciutada/ 
Per últim, les vivendes estan situades en municipis (pobles o ciutats) que pertànyen a províncies. Una província té molts municipis però un municipi només pot pertànyer a una provincia. S'ha donat el cas que el nom d'un municipi pot estar repetit en diferents províncies, és per això que per identificar totalment un municipi, aquest necessitarà de la seva provincia.
També ens interessarà saber la Comarca (encara que només pels municipis i províncies de Catalunya). 
A una comarca pertanyen moltes províncies i per aquest motiu a una Comarca també hi pertanyen molts municipis. 
De cada municipi ens interessarà saber a més del seu nom i els seus codis de referència, el codi INE (que haurà de ser un codi autogenerat) busqueu informació sobre el codi INE (5 dígits).
També emmagatzemarem del municipi, les seves coordenades de població en format UTM i en format de coordenades geogràfiques o GMS (longitud i latitud), també i de forma autogenerada, calcularem les coordenades en format vectorial o POINT. 
Per crear la BBDD es proporcionaran un arxius CSV de dades de municipis, províncies i comarques.
Per la resta de taules, s'hauran d'omplir totes amb dades fent servir INSERT, LOAD DATA, mysqlimport, etc.. allò que cregueu convenient.
El mínim seran 100 registres per taula. Les dades es poden obtenir de forma anonimitzada i no invasiva, de webs públiques com habitaclia, fotocasa, idealista, etc.. o a partir d'uns arxius CSV que es proporcionaran amb dades d'habitatges que haureu de transformar i obtenir els que faltin de forma randomitzada.

Us facilito l'arxiu que relaciona municipi, provincia i comarca, juntament amb les dades de geolocalització (recordeu que el tipus POINT es calculable igual que el codi INE).