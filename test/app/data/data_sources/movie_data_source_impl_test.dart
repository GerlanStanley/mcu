import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:mcu/app/domain/params/params.dart';
import 'package:mcu/app/domain/entities/entities.dart';
import 'package:mcu/app/data/data_sources/data_sources.dart';
import 'package:mcu/core/failures/failures.dart';
import 'package:mcu/core/helpers/http/http.dart';

class MockHttpHelper extends Mock implements HttpHelper {}

void main() {
  late MockHttpHelper httpHelper;
  late MovieDataSourceImpl dataSource;
  late GetMoviesParams params;

  setUp(() {
    httpHelper = MockHttpHelper();
    dataSource = MovieDataSourceImpl(httpHelper);
    params = GetMoviesParams(exampleFilter: "teste");

    registerFallbackValue(params);
  });

  test("Deve retornar uma List<MovieEntity>", () async {
    when(
      () => httpHelper.get(
        any(),
        queryParameters: any(named: "queryParameters"),
      ),
    ).thenAnswer((_) async => successJson);

    var result = await dataSource.getAll(params: params);

    expect(result, isA<List<MovieEntity>>());
  });

  test("Conferindo se está passando os params no queryParameters", () async {
    when(
      () => httpHelper.get(
        any(),
        queryParameters: {
          "example_filter": "teste",
        },
      ),
    ).thenAnswer((_) async => successJson);

    var result = await dataSource.getAll(params: params);

    expect(result, isA<List<MovieEntity>>());
  });

  test("Deve lançar uma HttpFailure quando status diferente de 200", () async {
    when(
      () => httpHelper.get(
        any(),
        queryParameters: any(named: "queryParameters"),
      ),
    ).thenThrow(
      BadRequestHttpFailure(message: ""),
    );

    var result = dataSource.getAll(params: params);

    expect(result, throwsA(isA<HttpFailure>()));
  });

  test(
    "Deve retornar um ParseFailure quando der qualquer outra exceção",
    () async {
      when(
        () => httpHelper.get(
          any(),
          queryParameters: any(named: "queryParameters"),
        ),
      ).thenThrow(Exception());

      var result = dataSource.getAll(params: params);

      expect(result, throwsA(isA<ParseFailure>()));
    },
  );

  test(
    "Deve retornar um ParseFailure quando não conseguir parsear a resposta",
    () async {
      when(
        () => httpHelper.get(
          any(),
          queryParameters: any(named: "queryParameters"),
        ),
      ).thenAnswer((_) async => invalidJson);

      var result = dataSource.getAll(params: params);

      expect(result, throwsA(isA<ParseFailure>()));
    },
  );
}

final successJson = jsonDecode(r'''
{
    "mcu": [
        {
            "adult": false,
            "backdrop_path": "/yFuKvT4Vm3sKHdFY4eG6I4ldAnn.jpg",
            "genre_ids": [
                28,
                12,
                878
            ],
            "id": 1771,
            "original_language": "en",
            "original_title": "Captain America: The First Avenger",
            "overview": "Steve Rogers é um jovem que participa de experiências visando a criação do supersoldado americano. Quando os oficiais militares conseguem transformá-lo em uma arma humana, eles percebem que não podem arriscar a vida do jovem nas batalhas de guerra.",
            "popularity": 44.224,
            "poster_path": "/xYijVAPunk6neVW2KHKE4Lp45ZU.jpg",
            "release_date": "2011-07-22",
            "title": "Capitão América: O Primeiro Vingador",
            "video": false,
            "vote_average": 7,
            "vote_count": 16878
        },
        {
            "adult": false,
            "backdrop_path": "/w2PMyoyLU22YvrGK3smVM9fW1jj.jpg",
            "genre_ids": [
                28,
                12,
                878
            ],
            "id": 299537,
            "original_language": "en",
            "original_title": "Captain Marvel",
            "overview": "Capitã Marvel, parte do exército de elite dos Kree, uma raça alienígena, encontra-se no meio de uma batalha entre seu povo e os Skrulls. Ao tentar impedir uma invasão de larga escala na Terra, em 1995, ela tem memórias recorrentes de uma outra vida, como Carol Danvers, agente da Força Aérea norte-americana. Com a ajuda de Nick Fury, Capitã Marvel precisa descobrir os segredos de seu passado e pôr um fim ao conflito intergalático com os Skrulls.",
            "popularity": 158.513,
            "poster_path": "/hVgLHgnsO46oSHJy5I4ekhqtoYv.jpg",
            "release_date": "2019-03-06",
            "title": "Capitã Marvel",
            "video": false,
            "vote_average": 6.9,
            "vote_count": 11441
        },
        {
            "adult": false,
            "backdrop_path": "/7vMqYIHu2E5CbvWr6tmNhYulDfS.jpg",
            "genre_ids": [
                28,
                878,
                12
            ],
            "id": 1726,
            "original_language": "en",
            "original_title": "Iron Man",
            "overview": "Tony Stark (Robert Downey Jr.) é um industrial bilionário, que também é um brilhante inventor. Ao ser sequestrado ele é obrigado por terroristas a construir uma arma devastadora mas, ao invés disto, constrói uma armadura de alta tecnologia que permite que fuja de seu cativeiro. A partir de então ele passa a usá-la para combater o crime, sob o alter-ego do Homem de Ferro.",
            "popularity": 74.915,
            "poster_path": "/imYhKyT1tjFX3QLgzwIDa7JZhxi.jpg",
            "release_date": "2008-04-30",
            "title": "Homem de Ferro",
            "video": false,
            "vote_average": 7.6,
            "vote_count": 20705
        },
        {
            "adult": false,
            "backdrop_path": "/6zINLC59ButA0fjAQIyJmFFNdjM.jpg",
            "genre_ids": [
                12,
                28,
                878
            ],
            "id": 10138,
            "original_language": "en",
            "original_title": "Iron Man 2",
            "overview": "Em um mundo ciente da existência do Homem de Ferro, o inventor bilionário Tony Stark sofre pressão de todos os lados para compartilhar sua tecnologia com as forças armadas. Ele resiste para divulgar os segredos de sua inigualável armadura, com medo de que estas informações caiam nas mãos erradas.",
            "popularity": 60.659,
            "poster_path": "/vzROjQbgKWMVf2EldXipCcjpuBL.jpg",
            "release_date": "2010-04-28",
            "title": "Homem de Ferro 2",
            "video": false,
            "vote_average": 6.8,
            "vote_count": 16212
        },
        {
            "adult": false,
            "backdrop_path": "/kYd1ZMWvG9K2Jeop3XWXcTpJ2dB.jpg",
            "genre_ids": [
                28,
                878
            ],
            "id": 1927,
            "original_language": "en",
            "original_title": "Hulk",
            "overview": "Bruce Banner é um cientista e trabalha ao lado de sua grande paixão, a bela Betty Ross, em um projeto que envolve a reconstituição de tecidos com a utilização da radiação gama. O problema todo começa quando, após ter seus genes alterados por um acidente envolvendo a radiação gama, Bruce Banner passa a se transformar em um ser gigantesco e verde que expressa no corpo todos os seus demônios mais íntimos e pessoais.",
            "popularity": 31.389,
            "poster_path": "/1Kl74sn1p6thqUFU6atZA81NHfi.jpg",
            "release_date": "2003-06-19",
            "title": "Hulk",
            "video": false,
            "vote_average": 5.5,
            "vote_count": 4328
        },
        {
            "adult": false,
            "backdrop_path": "/3SDoquTjagne0jWzdxEu31KFLmw.jpg",
            "genre_ids": [
                12,
                14,
                28
            ],
            "id": 10195,
            "original_language": "en",
            "original_title": "Thor",
            "overview": "Como filho de Odin, rei dos deuses nórdicos, Thor logo herdará o trono de Asgard de seu idoso pai. Porém, no dia de sua coroação, Thor reage com brutalidade quando os inimigos dos deuses entram no palácio violando o tratado. Como punição, Odin manda Thor para a Terra. Enquanto seu irmão Loki conspira em Asgard, Thor, agora sem seus poderes, enfrenta sua maior ameaça..",
            "popularity": 72.888,
            "poster_path": "/yI6jOYR9xDpxXPKAO17YuIBfROd.jpg",
            "release_date": "2011-04-21",
            "title": "Thor",
            "video": false,
            "vote_average": 6.8,
            "vote_count": 16564
        },
        {
            "adult": false,
            "backdrop_path": "/nNmJRkg8wWnRmzQDe2FwKbPIsJV.jpg",
            "genre_ids": [
                878,
                28,
                12
            ],
            "id": 24428,
            "original_language": "en",
            "original_title": "The Avengers",
            "overview": "Loki, o irmão de Thor, ganha acesso ao poder ilimitado do cubo cósmico ao roubá-lo de dentro das instalações da S.H.I.E.L.D. Nick Fury, o diretor desta agência internacional que mantém a paz, logo reúne os únicos super-heróis que serão capazes de defender a Terra de ameaças sem precedentes. Homem de Ferro, Capitão América, Hulk, Thor, Viúva Negra e Gavião Arqueiro formam o time dos sonhos de Fury, mas eles precisam aprender a colocar os egos de lado e agir como um grupo em prol da humanidade.",
            "popularity": 114.72,
            "poster_path": "/u49fzmIJHkb1H4oGFTXtBGgaUS1.jpg",
            "release_date": "2012-04-25",
            "title": "Os Vingadores: The Avengers",
            "video": false,
            "vote_average": 7.7,
            "vote_count": 24788
        },
        {
            "adult": false,
            "backdrop_path": "/fmYRqXtoEOwk5VgTnIOgWNDyPeJ.jpg",
            "genre_ids": [
                28,
                12,
                878
            ],
            "id": 68721,
            "original_language": "en",
            "original_title": "Iron Man 3",
            "overview": "Depois de um inimigo reduzir o mundo de Tony Stark a destroços, o Homem de Ferro precisa aprender a confiar em seus instintos para proteger aqueles que ama, especialmente sua namorada, e lutar contra seu maior medo: o fracasso.",
            "popularity": 68.285,
            "poster_path": "/C7MZwRTjvEy7gkWcLJeBGZFE1w.jpg",
            "release_date": "2013-04-18",
            "title": "Homem de Ferro 3",
            "video": false,
            "vote_average": 6.9,
            "vote_count": 17841
        },
        {
            "adult": false,
            "backdrop_path": "/uhYoytlNaq46dG81wLmHqaSuzWu.jpg",
            "genre_ids": [
                28,
                12,
                14
            ],
            "id": 76338,
            "original_language": "en",
            "original_title": "Thor: The Dark World",
            "overview": "Thor precisa contar com a ajuda de seus companheiros e até de seu traiçoeiro irmão Loki em um plano audacioso para salvar o universo. Entretanto, os caminhos de Thor se cruzam com Jane Foster e, dessa vez, a vida dela está realmente em perigo.",
            "popularity": 67.887,
            "poster_path": "/oip30thvJBpJRveA13Rtd2am5Qg.jpg",
            "release_date": "2013-10-30",
            "title": "Thor: O Mundo Sombrio",
            "video": false,
            "vote_average": 6.6,
            "vote_count": 13481
        },
        {
            "adult": false,
            "backdrop_path": "/yHB0eNR8rvCpn0VdghEwBsXAC0N.jpg",
            "genre_ids": [
                28,
                12,
                878
            ],
            "id": 100402,
            "original_language": "en",
            "original_title": "Captain America: The Winter Soldier",
            "overview": "Após os eventos catastróficos em Nova York com Os Vingadores, Steve Rogers, segue tentando se ajustar ao mundo moderno. Porém, quando um colega da agência S.H.I.E.L.D. é atacado, Steve se vê preso em uma rede de intrigas que ameaça colocar o mundo em risco. Em parceria com a Viúva Negra e Falcão, seu novo aliado, o Capitão América tem que enfrentar um misterioso e inesperado inimigo, o Soldado Invernal.",
            "popularity": 39.218,
            "poster_path": "/iBFPjLLHXkBojKpWDluJxnpM24h.jpg",
            "release_date": "2014-03-20",
            "title": "Capitão América 2: O Soldado Invernal",
            "video": false,
            "vote_average": 7.7,
            "vote_count": 14611
        },
        {
            "adult": false,
            "backdrop_path": "/i34ijHY5hr52uYcKZ48wq7K6yUs.jpg",
            "genre_ids": [
                28,
                878,
                12
            ],
            "id": 118340,
            "original_language": "en",
            "original_title": "Guardians of the Galaxy",
            "overview": "O aventureiro do espaço Peter Quill torna-se presa de caçadores de recompensas depois que rouba a esfera de um vilão traiçoeiro, Ronan. Para escapar do perigo, ele faz uma aliança com um grupo de quatro extraterrestres. Quando Quill descobre que a esfera roubada possui um poder capaz de mudar os rumos do universo, ele e seu grupo deverão proteger o objeto para salvar o futuro da galáxia.",
            "popularity": 37.809,
            "poster_path": "/xaY92XMToaSnBuvCui3LHzNGqZB.jpg",
            "release_date": "2014-07-30",
            "title": "Guardiões da Galáxia",
            "video": false,
            "vote_average": 7.9,
            "vote_count": 22585
        },
        {
            "adult": false,
            "backdrop_path": "/tM894AtE7UQTJEoQG6qF6mdfSUT.jpg",
            "genre_ids": [
                12,
                28,
                878,
                35
            ],
            "id": 283995,
            "original_language": "en",
            "original_title": "Guardians of the Galaxy Vol. 2",
            "overview": "Os Guardiões precisam lutar para manter sua recém descoberta família unida, enquanto descobrem os mistérios sobre o verdadeiro pai de Peter Quill.",
            "popularity": 82.021,
            "poster_path": "/hXi3ExbRXnZCPbdHQkppQdcdMUF.jpg",
            "release_date": "2017-04-19",
            "title": "Guardiões da Galáxia Vol. 2",
            "video": false,
            "vote_average": 7.6,
            "vote_count": 16652
        },
        {
            "adult": false,
            "backdrop_path": "/xnqust9Li4oxfhXD5kcPi3UC8i4.jpg",
            "genre_ids": [
                28,
                12,
                878
            ],
            "id": 99861,
            "original_language": "en",
            "original_title": "Avengers: Age of Ultron",
            "overview": "Ao tentar proteger o planeta de ameaças, Tony Stark constrói um sistema de inteligência artificial que cuidaria da paz mundial. O projeto acaba dando errado e gera o nascimento do Ultron. Com o destino da Terra em jogo, os Vingadores terão que se unir para mais uma vez salvar a raça humana da extinção.",
            "popularity": 95.202,
            "poster_path": "/vGIIl89vglo66yUfbuTxzNAs4y5.jpg",
            "release_date": "2015-04-22",
            "title": "Vingadores: Era de Ultron",
            "video": false,
            "vote_average": 7.3,
            "vote_count": 17993
        },
        {
            "adult": false,
            "backdrop_path": "/7AyEEZVtFjNMCOEoz88pBqiAI8n.jpg",
            "genre_ids": [
                878,
                28,
                12
            ],
            "id": 102899,
            "original_language": "en",
            "original_title": "Ant-Man",
            "overview": "Dr. Hank Pym (Michael Douglas), o inventor da fórmula/ traje que permite o encolhimento, anos depois da descoberta, precisa impedir que seu ex-pupilo Darren Cross (Corey Stoll), consiga replicar o feito e vender a tecnologia para uma organização do mal. Depois de sair da cadeia, o trambiqueiro Scott Lang (Paul Rudd) está disposto a reconquistar o respeito da ex-mulher, Maggie (Judy Greer) e, principalmente, da filha. Com dificuldades de arrumar um emprego honesto, ele aceita praticar um último golpe. O que ele não sabia era que tudo não passava de um plano do Dr. Pym que, depois de anos observando o hábil ladrão, o escolhe para vestir o traje do Homem-Formiga.",
            "popularity": 51.753,
            "poster_path": "/yiLqv1gwBENjbqTAdPxW4LhX6aA.jpg",
            "release_date": "2015-07-14",
            "title": "Homem-Formiga",
            "video": false,
            "vote_average": 7.1,
            "vote_count": 15600
        },
        {
            "adult": false,
            "backdrop_path": "/kvRT3GwcnqGHzPjXIVrVPhUix7Z.jpg",
            "genre_ids": [
                12,
                28,
                878
            ],
            "id": 271110,
            "original_language": "en",
            "original_title": "Captain America: Civil War",
            "overview": "O ataque de Ultron fez com que os políticos buscassem algum meio de controlar os super-heróis, já que seus atos afetam toda a humanidade. Tal decisão coloca o Capitão América em rota de colisão com Tony Stark, o Homem de Ferro.",
            "popularity": 90.54,
            "poster_path": "/lS5XvvUcJy5rJcbmBeX1GPoMnWJ.jpg",
            "release_date": "2016-04-27",
            "title": "Capitão América: Guerra Civil",
            "video": false,
            "vote_average": 7.4,
            "vote_count": 18128
        },
        {
            "adult": false,
            "backdrop_path": "/tTlAA0REGPXSZPBfWyTW9ipIv1I.jpg",
            "genre_ids": [
                28,
                12,
                878,
                18
            ],
            "id": 315635,
            "original_language": "en",
            "original_title": "Spider-Man: Homecoming",
            "overview": "Depois de atuar ao lado dos Vingadores, chegou a hora do pequeno Peter Parker (Tom Holland) voltar para casa e para a sua vida, já não mais tão normal. Lutando diariamente contra pequenos crimes nas redondezas, ele pensa ter encontrado a missão de sua vida quando o terrível vilão Abutre (Michael Keaton) surge amedrontando a cidade. O problema é que a tarefa não será tão fácil como ele imaginava.",
            "popularity": 123.281,
            "poster_path": "/9Fgs1ewIZiBBTto1XDHeBN0D8ug.jpg",
            "release_date": "2017-07-05",
            "title": "Homem-Aranha: De Volta ao Lar",
            "video": false,
            "vote_average": 7.4,
            "vote_count": 16255
        },
        {
            "adult": false,
            "backdrop_path": "/sIwFcU1pql5a3LdZGxsRKi9JfTL.jpg",
            "genre_ids": [
                28,
                12,
                878
            ],
            "id": 284054,
            "original_language": "en",
            "original_title": "Black Panther",
            "overview": "O príncipe T'Challa retorna a Wakanda para ser coroado rei. Assumindo o manto de Pantera Negra, ele vai à caça de um vilão que roubou um precioso metal de seu país.",
            "popularity": 66.321,
            "poster_path": "/2yQUnpc1BXgesJrfcdoRa6jTAnA.jpg",
            "release_date": "2018-02-13",
            "title": "Pantera Negra",
            "video": false,
            "vote_average": 7.4,
            "vote_count": 17442
        },
        {
            "adult": false,
            "backdrop_path": "/aL53oMdZKZRJRH8txH07DLuleF9.jpg",
            "genre_ids": [
                28,
                12,
                14,
                878
            ],
            "id": 284052,
            "original_language": "en",
            "original_title": "Doctor Strange",
            "overview": "Da Marvel Studios vem “Doctor Strange”, a história do mundialmente famoso neurocirurgião Dr. Stephen Strange, cuja vida muda para sempre depois de um terrível acidente de carro, que o rouba do uso de suas mãos. Quando a medicina tradicional o falha, ele é forçado a procurar por cura e esperança, em um lugar improvável - um enclave misterioso conhecido como Kamar-Taj. Ele rapidamente descobre que isso não é apenas um centro de cura, mas também a linha de frente de uma batalha contra as forças ocultas invisíveis empenhadas em destruir nossa realidade. Em pouco tempo, Strange - armado com poderes mágicos recém-adquiridos - é forçado a escolher se quer retornar à sua vida de fortuna e status ou deixar tudo para trás para defender o mundo como o mais poderoso feiticeiro existente.",
            "popularity": 57.742,
            "poster_path": "/t0amAZ8KJFxBQZOxOnWlKVT4STi.jpg",
            "release_date": "2016-10-25",
            "title": "Doutor Estranho",
            "video": false,
            "vote_average": 7.4,
            "vote_count": 17040
        },
        {
            "adult": false,
            "backdrop_path": "/kaIfm5ryEOwYg8mLbq8HkPuM1Fo.jpg",
            "genre_ids": [
                28,
                12,
                35,
                14,
                878
            ],
            "id": 284053,
            "original_language": "en",
            "original_title": "Thor: Ragnarok",
            "overview": "Thor está preso do outro lado do universo. Ele precisa correr contra o tempo para voltar a Asgard e parar Ragnarok, a destruição de seu mundo, que está nas mãos da poderosa e implacável vilã Hela.",
            "popularity": 133.639,
            "poster_path": "/bLpIFiuWF1bKnBqi7LqnJcLHtN.jpg",
            "release_date": "2017-10-25",
            "title": "Thor: Ragnarok",
            "video": false,
            "vote_average": 7.6,
            "vote_count": 15975
        },
        {
            "adult": false,
            "backdrop_path": "/xjFgtltOOuBtLdNedQH8M1TTrjc.jpg",
            "genre_ids": [
                28,
                12,
                878
            ],
            "id": 363088,
            "original_language": "en",
            "original_title": "Ant-Man and the Wasp",
            "overview": "Scott Lang lida com as consequências de suas escolhas tanto como super-herói quanto como pai. Enquanto tenta reequilibrar sua vida com suas responsabilidades como o Homem-Formiga, ele é confrontado por Hope van Dyne e Dr. Hank Pym com uma nova missão urgente. Scott deve mais uma vez vestir o uniforme e aprender a lutar ao lado da Vespa, trabalhando em conjunto para descobrir segredos do passado.",
            "popularity": 71.245,
            "poster_path": "/smRrzh8W4PfIYiqAEqc6U1D6Ekl.jpg",
            "release_date": "2018-07-04",
            "title": "Homem-Formiga e a Vespa",
            "video": false,
            "vote_average": 7,
            "vote_count": 9858
        },
        {
            "adult": false,
            "backdrop_path": "/3pwCakKsFHq2pnO5T3RxkhMEGVa.jpg",
            "genre_ids": [
                28,
                12,
                53
            ],
            "id": 497698,
            "original_language": "en",
            "original_title": "Black Widow",
            "overview": "Natasha Romanoff, também conhecida como \"Viúva Negra\", confronta as partes mais sombrias do seu passado quando surge uma conspiração perigosa ligada a ele. Perseguida por uma força que não irá parar até derrubá-la, Natasha deve lidar com sua história como espiã e os relacionamentos interrompidos que ela deixou para trás muito antes de se tornar uma Vingadora.",
            "popularity": 116.837,
            "poster_path": "/38SVfXq1O45HKQ2RFUPvECz8Pse.jpg",
            "release_date": "2021-07-07",
            "title": "Viúva Negra",
            "video": false,
            "vote_average": 1,
            "vote_count": 1
        },
        {
            "adult": false,
            "backdrop_path": "/lmZFxXgJE3vgrciwuDib0N8CfQo.jpg",
            "genre_ids": [
                12,
                28,
                878
            ],
            "id": 299536,
            "original_language": "en",
            "original_title": "Avengers: Infinity War",
            "overview": "Homem de Ferro, Thor, Hulk e os Vingadores se unem para combater seu inimigo mais poderoso, o maligno Thanos. Em uma missão para coletar todas as seis pedras infinitas, Thanos planeja usá-las para infligir sua vontade maléfica sobre a realidade.",
            "popularity": 281.112,
            "poster_path": "/89QTZmn34iwXYeCpVxhC9UrT8sX.jpg",
            "release_date": "2018-04-25",
            "title": "Vingadores: Guerra Infinita",
            "video": false,
            "vote_average": 8.3,
            "vote_count": 21942
        },
        {
            "adult": false,
            "backdrop_path": "/7RyHsO4yDXtBv1zUU3mTpHeQ0d5.jpg",
            "genre_ids": [
                12,
                878,
                28
            ],
            "id": 299534,
            "original_language": "en",
            "original_title": "Avengers: Endgame",
            "overview": "Após os eventos devastadores de \"Vingadores: Guerra Infinita\", o universo está em ruínas devido aos esforços do Titã Louco, Thanos. Com a ajuda de aliados remanescentes, os Vingadores devem se reunir mais uma vez a fim de desfazer as ações de Thanos e restaurar a ordem no universo de uma vez por todas, não importando as consequências.",
            "popularity": 242.004,
            "poster_path": "/q6725aR8Zs4IwGMXzZT8aC8lh41.jpg",
            "release_date": "2019-04-24",
            "title": "Vingadores: Ultimato",
            "video": false,
            "vote_average": 8.3,
            "vote_count": 18277
        },
        {
            "adult": false,
            "backdrop_path": "/8XiTPU1zfy41Xgg96TCHXj4uQJf.jpg",
            "genre_ids": [
                28,
                12,
                878
            ],
            "id": 429617,
            "original_language": "en",
            "original_title": "Spider-Man: Far From Home",
            "overview": "Peter Parker está em uma viagem de duas semanas pela Europa, ao lado de seus amigos de colégio, quando é surpreendido pela visita de Nick Fury. Convocado para mais uma missão heroica, ele precisa enfrentar vários vilões que surgem em cidades-símbolo do continente, como Londres, Paris e Veneza, e também a aparição do enigmático Mysterio.",
            "popularity": 212.768,
            "poster_path": "/tX0o4AdHpidgniTWwfzK0dNTKrc.jpg",
            "release_date": "2019-06-28",
            "title": "Homem-Aranha: Longe de Casa",
            "video": false,
            "vote_average": 7.5,
            "vote_count": 9959
        }
    ]
}
''');

final invalidJson = jsonDecode(r'''
{
    "id": 37
}
''');
