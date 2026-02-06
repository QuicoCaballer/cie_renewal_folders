class ItalianMunicipalities {
  static const List<String> municipalities = [
    // Principales ciudades
    'Roma', 'Milano', 'Napoli', 'Torino', 'Palermo', 'Genova', 'Bologna', 
    'Firenze', 'Bari', 'Catania', 'Venezia', 'Verona', 'Messina', 'Padova',
    'Trieste', 'Brescia', 'Parma', 'Prato', 'Taranto', 'Modena', 'Reggio Calabria',
    'Reggio Emilia', 'Perugia', 'Livorno', 'Ravenna', 'Cagliari', 'Foggia',
    'Rimini', 'Salerno', 'Ferrara', 'Sassari', 'Latina', 'Giugliano in Campania',
    'Monza', 'Siracusa', 'Pescara', 'Bergamo', 'Forlì', 'Trento', 'Vicenza',
    
    // Región de Lombardía
    'Abbiategrasso', 'Albino', 'Alzano Lombardo', 'Arcore', 'Desio', 'Busto Arsizio',
    'Cantù', 'Carate Brianza', 'Cernusco sul Naviglio', 'Cesano Maderno', 'Cinisello Balsamo',
    'Como', 'Corbetta', 'Crema', 'Cremona', 'Cusano Milanino', 'Dalmine', 'Gorgonzola',
    'Lecco', 'Lodi', 'Magenta', 'Mantova', 'Meda', 'Melzo', 'Merate', 'Rho',
    'Saronno', 'Seregno', 'Sesto San Giovanni', 'Sondrio', 'Treviglio', 'Varese',
    'Vigevano', 'Vimercate', 'Voghera',
    
    // Región de Lazio
    'Anzio', 'Aprilia', 'Ardea', 'Civitavecchia', 'Colleferro', 'Fiumicino',
    'Fondi', 'Formia', 'Frosinone', 'Guidonia Montecelio', 'Ladispoli', 'Nettuno',
    'Pomezia', 'Rieti', 'Terracina', 'Tivoli', 'Velletri', 'Viterbo',
    
    // Región de Campania
    'Acerra', 'Afragola', 'Agropoli', 'Aversa', 'Avellino', 'Bacoli', 'Battipaglia',
    'Benevento', 'Capua', 'Cardito', 'Casalnuovo di Napoli', 'Casavatore', 'Caserta',
    'Castellammare di Stabia', 'Casoria', 'Cava de\' Tirreni', 'Ercolano', 'Giugliano',
    'Marano di Napoli', 'Melito di Napoli', 'Mugnano di Napoli', 'Nocera Inferiore',
    'Nola', 'Pagani', 'Pomigliano d\'Arco', 'Pompei', 'Portici', 'Pozzuoli',
    'Qualiano', 'Quarto', 'San Giorgio a Cremano', 'Scafati', 'Sorrento', 'Torre Annunziata',
    'Torre del Greco', 'Vico Equense',
    
    // Región de Veneto
    'Abano Terme', 'Arzignano', 'Bassano del Grappa', 'Belluno', 'Bussolengo',
    'Camposampiero', 'Castelfranco Veneto', 'Chioggia', 'Cittadella', 'Conegliano',
    'Este', 'Jesolo', 'Legnago', 'Mestre', 'Mirano', 'Montebelluna', 'Monselice',
    'Motta di Livenza', 'Noale', 'Portogruaro', 'Rovigo', 'San Bonifacio', 'San Donà di Piave',
    'Schio', 'Selvazzano Dentro', 'Treviso', 'Valdagno', 'Vicenza', 'Villafranca di Verona',
    
    // Región de Piemonte
    'Alba', 'Alessandria', 'Asti', 'Beinasco', 'Biella', 'Borgomanero', 'Bra',
    'Casale Monferrato', 'Chieri', 'Chivasso', 'Collegno', 'Cuneo', 'Grugliasco',
    'Ivrea', 'Moncalieri', 'Nichelino', 'Novara', 'Orbassano', 'Pinerolo', 'Rivoli',
    'Settimo Torinese', 'Verbania', 'Vercelli',
    
    // Región de Emilia-Romagna
    'Carpi', 'Casalecchio di Reno', 'Castelfranco Emilia', 'Cesena', 'Faenza',
    'Fidenza', 'Fiorano Modenese', 'Formigine', 'Imola', 'Lugo', 'Mirandola',
    'Modena', 'Piacenza', 'Reggio Emilia', 'San Giovanni in Persiceto', 'Sassuolo',
    
    // Región de Toscana
    'Arezzo', 'Carrara', 'Empoli', 'Grosseto', 'Lucca', 'Massa', 'Pistoia',
    'Pisa', 'Pontedera', 'Scandicci', 'Sesto Fiorentino', 'Siena', 'Viareggio',
    
    // Región de Puglia
    'Altamura', 'Andria', 'Barletta', 'Bitonto', 'Brindisi', 'Cerignola',
    'Corato', 'Fasano', 'Foggia', 'Francavilla Fontana', 'Gallipoli', 'Grottaglie',
    'Lecce', 'Manfredonia', 'Martina Franca', 'Molfetta', 'Monopoli', 'Mottola',
    'San Severo', 'Trani',
    
    // Región de Sicilia
    'Acireale', 'Agrigento', 'Alcamo', 'Augusta', 'Bagheria', 'Caltagirone',
    'Caltanissetta', 'Castelvetrano', 'Enna', 'Gela', 'Marsala', 'Mazara del Vallo',
    'Messina', 'Milazzo', 'Modica', 'Niscemi', 'Palermo', 'Ragusa', 'Siracusa',
    'Termini Imerese', 'Trapani', 'Vittoria',
    
    // Región de Calabria
    'Castrovillari', 'Catanzaro', 'Cosenza', 'Crotone', 'Lamezia Terme',
    'Reggio Calabria', 'Rossano', 'Vibo Valentia',
    
    // Región de Sardegna
    'Alghero', 'Carbonia', 'Iglesias', 'Nuoro', 'Olbia', 'Oristano',
    'Quartu Sant\'Elena', 'Sassari', 'Selargius',
    
    // Región de Abruzzo
    'Chieti', 'Giulianova', 'L\'Aquila', 'Lanciano', 'Montesilvano',
    'Pescara', 'Pineto', 'Roseto degli Abruzzi', 'Teramo', 'Vasto',
    
    // Región de Marche
    'Ancona', 'Ascoli Piceno', 'Civitanova Marche', 'Fano', 'Jesi',
    'Macerata', 'Pesaro', 'Senigallia', 'Urbino',
    
    // Región de Liguria
    'Albenga', 'Imperia', 'La Spezia', 'Sanremo', 'Savona', 'Ventimiglia',
    
    // Región de Umbria
    'Assisi', 'Città di Castello', 'Foligno', 'Gubbio', 'Orvieto',
    'Spoleto', 'Terni',
    
    // Región de Molise
    'Campobasso', 'Isernia', 'Termoli',
    
    // Región de Basilicata
    'Matera', 'Potenza',
    
    // Región de Trentino-Alto Adige
    'Bolzano', 'Merano', 'Trento', 'Rovereto',
    
    // Región de Friuli-Venezia Giulia
    'Gorizia', 'Monfalcone', 'Pordenone', 'Trieste', 'Udine',
    
    // Valle d'Aosta
    'Aosta',
    
    // Otros municipios importantes
    'Affi', 'Agna', 'Airuno', 'Alanno', 'Albano Laziale', 'Albavilla', 'Albignasego',
    'Almenno San Bartolomeo', 'Almè', 'Altavilla Vicentina', 'Altopascio', 'Amatrice',
    'Amelia', 'Anagni', 'Ancona', 'Angera', 'Anghiari', 'Anzola dell\'Emilia',
    'Aosta', 'Ariccia', 'Arona', 'Arsiero', 'Arsoli', 'Artena', 'Arzano',
    'Assago', 'Assemini', 'Asti', 'Atella', 'Atripalda', 'Avigliano', 'Avio',
    'Azeglio', 'Bagnacavallo', 'Bagnara Calabra', 'Bagno a Ripoli', 'Baiano',
    'Balangero', 'Barga', 'Bariano', 'Barlassina', 'Barrafranca', 'Barzanò',
    'Bedizzole', 'Bellinzago Novarese', 'Bellusco', 'Belpasso', 'Bene Vagienna',
    'Bentivoglio', 'Besnate', 'Bevagna', 'Biandronno', 'Bibbiano', 'Biella',
    'Binasco', 'Bisaccia', 'Bisceglie', 'Bisignano', 'Bobbio', 'Bogogno',
    'Boissano', 'Bollate', 'Bondeno', 'Borgo San Lorenzo', 'Borgo Val di Taro',
    'Borgosatollo', 'Boscoreale', 'Bovezzo', 'Bra', 'Bracciano', 'Brandizzo',
    'Brembate', 'Breno', 'Bresso', 'Bricherasio', 'Brindisi', 'Briosco',
    'Broni', 'Brugherio', 'Brugnera', 'Brugine', 'Brunate', 'Buccinasco',
    'Budrio', 'Buggiano', 'Busnago', 'Bussero', 'Buttapietra', 'Buttigliera Alta',
    'Cadorago', 'Cagliari', 'Cagnano Varano', 'Cairo Montenotte', 'Calcinaia',
    'Calco', 'Caldiero', 'Calenzano', 'Caltrano', 'Caluso', 'Camaiore',
    'Camogli', 'Campagna Lupia', 'Campegine', 'Campi Bisenzio', 'Campobello di Mazara',
    'Campoformido', 'Campogalliano', 'Canale', 'Candia Canavese', 'Candiana',
    'Canelli', 'Caneva', 'Canicattì', 'Caorle', 'Capannoli', 'Capannori',
    'Capena', 'Capraia e Limite', 'Capriate San Gervasio', 'Carate Urio', 'Carbonera',
    'Carceri', 'Cardano al Campo', 'Carignano', 'Carmagnola', 'Carmiano',
    'Carpenedolo', 'Carpiano', 'Carpi', 'Carrara', 'Carsoli', 'Carugate',
    'Casal di Principe', 'Casale sul Sile', 'Casalecchio', 'Casalgrande', 'Casalmaggiore',
    'Casalpusterlengo', 'Casalserugo', 'Casamassima', 'Casandrino', 'Casape',
    'Casarano', 'Casarsa della Delizia', 'Casatenovo', 'Caselle Torinese', 'Caserta',
    'Casier', 'Casorate Primo', 'Casorate Sempione', 'Cassago Brianza', 'Cassano d\'Adda',
    'Cassano Magnago', 'Cassina de\' Pecchi', 'Cassola', 'Castel Bolognese', 'Castel d\'Ario',
    'Castel Goffredo', 'Castel Maggiore', 'Castel San Giorgio', 'Castel San Giovanni',
    'Castel San Pietro Terme', 'Castel Volturno', 'Castelbelforte', 'Castelbellino',
    'Castelcovati', 'Castelfidardo', 'Castelfranco di Sotto', 'Castelfranco Emilia',
    'Castelgomberto', 'Castellalto', 'Castellamonte', 'Castellana Grotte', 'Castellanza',
    'Castellarano', 'Castelleone', 'Castello di Godego', 'Castelli Calepio', 'Castelnovo di Sotto',
    'Castelnovo ne\' Monti', 'Castelnuovo Berardenga', 'Castelnuovo del Garda', 'Castelnuovo di Garfagnana',
    'Castelnuovo Rangone', 'Castelvetro di Modena', 'Castelvetro Piacentino', 'Castenaso', 'Castenedolo',
    'Castiglion Fiorentino', 'Castiglione del Lago', 'Castiglione della Pescaia', 'Castiglione delle Stiviere',
    'Castiglione Olona', 'Castions di Strada', 'Castri di Lecce', 'Castrignano del Capo', 'Castrofilippo',
    'Catania', 'Cattolica', 'Cava Manara', 'Cavaglia', 'Cavalese', 'Cavallasca',
    'Cavallermaggiore', 'Cavenago di Brianza', 'Cavriago', 'Cazzago San Martino', 'Cecina',
    'Ceggia', 'Celano', 'Cellatica', 'Cellole', 'Cenate Sotto', 'Cene',
    'Centallo', 'Cento', 'Ceranesi', 'Cercola', 'Cerea', 'Cerese',
    'Ceriano Laghetto', 'Cerignola', 'Cermenate', 'Cernusco Lombardone', 'Cerretto Langhe',
    'Cerreto Guidi', 'Cerro al Lambro', 'Cerro Maggiore', 'Cervarese Santa Croce', 'Cervia',
    'Cervignano del Friuli', 'Cesano Boscone', 'Cesenatico', 'Ceva', 'Chiari',
    'Chiavari', 'Chiavenna', 'Chienes', 'Chiesa in Valmalenco', 'Chiesina Uzzanese',
    'Chignolo Po', 'Chioggia', 'Chiuduno', 'Chiusa', 'Chiusa di Pesio',
    'Chiusi', 'Ciampino', 'Cibiana di Cadore', 'Cilavegna', 'Cingoli',
    'Cinisello', 'Cinto Caomaggiore', 'Ciriè', 'Ciserano', 'Cislago',
    'Cisterna di Latina', 'Cisternino', 'Cittadella', 'Città Sant\'Angelo', 'Civate',
    'Civezzano', 'Cividale del Friuli', 'Civo', 'Cles', 'Clusone',
    'Coccaglio', 'Codogno', 'Codigoro', 'Codroipo', 'Cogoleto',
    'Cogliate', 'Cogollo del Cengio', 'Colere', 'Cologna Veneta', 'Cologno al Serio',
    'Cologno Monzese', 'Cologne', 'Colonna', 'Colorina', 'Colorno',
    'Colturano', 'Comacchio', 'Comeglians', 'Comiso', 'Commessaggio',
    'Concesio', 'Concordia sulla Secchia', 'Condove', 'Conselice', 'Conselve',
    'Conversano', 'Copparo', 'Corato', 'Corciano', 'Cordenons',
    'Cordignano', 'Coriano', 'Corigliano Calabro', 'Corigliano d\'Otranto', 'Corinaldo',
    'Cormano', 'Cormons', 'Cornaredo', 'Cornate d\'Adda', 'Cornedo Vicentino',
    'Correggio', 'Corridonia', 'Corsano', 'Corsico', 'Cortaccia sulla Strada del Vino',
    'Cortale', 'Corte Franca', 'Cortemaggiore', 'Cortemilia', 'Corteno Golgi',
    'Corteolona', 'Corti', 'Cortina d\'Ampezzo', 'Cortona', 'Corvara in Badia',
    'Cossato', 'Cosseria', 'Costabissara', 'Costigliole d\'Asti', 'Cotignola',
    'Covo', 'Creazzo', 'Credaro', 'Credera Rubbiano', 'Crema',
    'Cremasca', 'Cremenaga', 'Crescentino', 'Crespano del Grappa', 'Crespellano',
    'Crespiatica', 'Cressa', 'Crispano', 'Crispiano', 'Crocetta del Montello',
    'Cuggiono', 'Cumiana', 'Cunardo', 'Cuneo', 'Cuorgnè',
    'Cupello', 'Cupra Marittima', 'Cureggio', 'Curno', 'Cursi',
    'Cusago', 'Cutro', 'Cutrofiano',
  ];
}