BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "django_session" (
	"session_key"	varchar(40) NOT NULL,
	"session_data"	text NOT NULL,
	"expire_date"	datetime NOT NULL,
	PRIMARY KEY("session_key")
);
CREATE TABLE IF NOT EXISTS "api_review_review" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"text"	varchar(300) NOT NULL,
	"score"	integer,
	"author_id"	integer NOT NULL,
	"title_id"	integer,
	"pub_date"	datetime NOT NULL,
	FOREIGN KEY("author_id") REFERENCES "api_user_user"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("title_id") REFERENCES "api_titles_title"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "api_review_comment" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"text"	text NOT NULL,
	"pub_date"	datetime NOT NULL,
	"author_id"	integer NOT NULL,
	"review_id"	integer NOT NULL,
	FOREIGN KEY("author_id") REFERENCES "api_user_user"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("review_id") REFERENCES "api_review_review"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "api_titles_title_genre" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"title_id"	integer NOT NULL,
	"genre_id"	integer NOT NULL,
	FOREIGN KEY("title_id") REFERENCES "api_titles_title"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("genre_id") REFERENCES "api_titles_genre"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "api_titles_title" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"name"	varchar(300) NOT NULL,
	"year"	integer,
	"description"	varchar(1000) NOT NULL,
	"rating"	integer,
	"category_id"	integer,
	FOREIGN KEY("category_id") REFERENCES "api_titles_category"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "api_titles_genre" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"name"	varchar(300) NOT NULL,
	"slug"	varchar(50) NOT NULL UNIQUE
);
CREATE TABLE IF NOT EXISTS "api_titles_category" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"name"	varchar(300) NOT NULL,
	"slug"	varchar(50) NOT NULL UNIQUE
);
CREATE TABLE IF NOT EXISTS "django_admin_log" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"action_time"	datetime NOT NULL,
	"object_id"	text,
	"object_repr"	varchar(200) NOT NULL,
	"change_message"	text NOT NULL,
	"content_type_id"	integer,
	"user_id"	integer NOT NULL,
	"action_flag"	smallint unsigned NOT NULL CHECK("action_flag">=0),
	FOREIGN KEY("content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "api_user_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "api_user_user_user_permissions" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"user_id"	integer NOT NULL,
	"permission_id"	integer NOT NULL,
	FOREIGN KEY("permission_id") REFERENCES "auth_permission"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "api_user_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "api_user_user_groups" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"user_id"	integer NOT NULL,
	"group_id"	integer NOT NULL,
	FOREIGN KEY("group_id") REFERENCES "auth_group"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "api_user_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "api_user_user" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"password"	varchar(128) NOT NULL,
	"last_login"	datetime,
	"is_superuser"	bool NOT NULL,
	"first_name"	varchar(30) NOT NULL,
	"last_name"	varchar(150) NOT NULL,
	"is_staff"	bool NOT NULL,
	"is_active"	bool NOT NULL,
	"date_joined"	datetime NOT NULL,
	"role"	varchar(9) NOT NULL,
	"bio"	varchar(250),
	"email"	varchar(254) NOT NULL UNIQUE,
	"username"	varchar(250) UNIQUE,
	"confirm_code"	varchar(5) NOT NULL
);
CREATE TABLE IF NOT EXISTS "auth_group" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"name"	varchar(150) NOT NULL UNIQUE
);
CREATE TABLE IF NOT EXISTS "auth_permission" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"content_type_id"	integer NOT NULL,
	"codename"	varchar(100) NOT NULL,
	"name"	varchar(255) NOT NULL,
	FOREIGN KEY("content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "auth_group_permissions" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"group_id"	integer NOT NULL,
	"permission_id"	integer NOT NULL,
	FOREIGN KEY("permission_id") REFERENCES "auth_permission"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("group_id") REFERENCES "auth_group"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "django_content_type" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"app_label"	varchar(100) NOT NULL,
	"model"	varchar(100) NOT NULL
);
CREATE TABLE IF NOT EXISTS "django_migrations" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"app"	varchar(255) NOT NULL,
	"name"	varchar(255) NOT NULL,
	"applied"	datetime NOT NULL
);
INSERT INTO "django_session" VALUES ('6wqwf3qw5ow1k2tdgdk3yuslqj440sdx','ZDA0Mzk2NDQwNmIyYjU2NDFkNGMxMWUyOTU0OTE2NDQwZmM0NTg5OTp7Il9hdXRoX3VzZXJfaWQiOiIxMCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiOWMzYzY0NTdlNTdjNzJiNDAzMGI1ODY4ZWQ0ZWVhNTYzY2QxODYyNSJ9','2020-10-16 16:47:07.288504');
INSERT INTO "api_review_review" VALUES (1,'"Ставлю десять звёзд!
...Эти голоса были чище и светлее тех, о которых мечтали в этом сером, убогом месте. Как будто две птички влетели и своими голосами развеяли стены наших клеток, и на короткий миг каждый человек в Шоушенке почувствовал себя свободным."',10,100,1,'2019-09-24T21:08:21.567Z');
INSERT INTO "api_review_review" VALUES (2,'"Не привыкай
«Эти стены имеют одно свойство: сначала ты их ненавидишь, потом привыкаешь, а потом не можешь без них жить»"',10,101,1,'2019-09-24T21:08:21.567Z');
INSERT INTO "api_review_review" VALUES (3,'"Фильм, разобранный на цитаты, достоин высшей оценки. Десять с плюсом (жаль, тут плюса нет)
"Ты пришел и говоришь: "Дон Корлеоне, мне нужна справедливость". Но ты просишь без уважения, ты не предлагаешь дружбу, ты даже не назвал меня Крестным Отцом.""',10,102,2,'2019-09-24T21:08:21.567Z');
INSERT INTO "api_review_review" VALUES (4,'"Жестокий, жестокий, жестокий мир, не о таком мечтали мы в детстве!!111
***Отец сделал ему предложение, от которого он не смог отказаться. Лука Брази держал пистолет у его виска, и отец предложил выбор: либо на контракте мозги, либо подпись.***"',1,103,2,'2019-09-24T21:08:21.567Z');
INSERT INTO "api_review_review" VALUES (5,'"Это мои соседи! Ставлю три звезды за то, что они дважды отдавили мне окном пальцы:
----------------------
— Вы живёте в плохом районе?
— Не то слово. Однажды с нашей улицы угнали полицейскую машину с двумя полицейскими. В дом всё время лезут воры. Каждый раз, как я пытаюсь закрыть окно, прищемляю кому-нибудь пальцы."',3,104,2,'2019-09-24T21:08:21.567Z');
INSERT INTO "api_review_review" VALUES (6,'"Всё, как в разных языках программирования! В основном — похоже, но вот эти маленькие различия выводят из себя. 
Великий фильм на все случаи жизни!
=====================================================
— А знаешь, как в Париже называют четвертьфунтовый чизбургер?
— Что, они не зовут его четвертьфунтовый чизбургер?
— У них там метрическая система. Они вообще там не понимают, что за хрен четверть фунта.
— И как они его зовут?
— Они зовут его «Роял чизбургер».
— «Роял чизбургер»? А как же тогда они зовут «Биг Мак»?
— «Биг Мак» это «Биг Мак», только они называют его «Лё Биг Мак»."',8,100,5,'2019-09-24T21:08:21.567Z');
INSERT INTO "api_review_review" VALUES (7,'Ничего не понятно. Они там что, страницы сценария перепутали? Его сперва убили, а потом он опять жив, а они сперва в футболках, потом в костюмах, а потом опять в футболках. Ерунда полная',1,101,5,'2019-09-24T21:08:21.567Z');
INSERT INTO "api_review_review" VALUES (8,'"Очень поучительный фильм о том, что такое хорошо, что такое плохо и почему не надо читать в туалете.
Твердая восьмёрка"',8,102,5,'2019-09-24T21:08:21.567Z');
INSERT INTO "api_review_review" VALUES (9,'"Посмотрел фильм. 
— На свете есть два типа людей: те, кто копает и те, у кого заряжен револьвер.
Пойду копать, как велел Клинт. 
Девять баллов."',9,103,6,'2019-09-24T21:08:21.567Z');
INSERT INTO "api_review_review" VALUES (10,'"Вечная проблема всех злодеев, болтающих-болтающих-болтающих вместо того, чтобы просто застрелить противника, одним махом решена в этой сцене.
За одно это фильм заслуживает высшего балла
"Пришел стрелять - стреляй, а не болтай!""',10,104,6,'2019-09-24T21:08:21.567Z');
INSERT INTO "api_review_review" VALUES (11,'Фильм про жадных, корыстных, грязных и безнравственных людей, чему он может научить зрителя?!!',2,100,6,'2019-09-24T21:08:21.567Z');
INSERT INTO "api_review_review" VALUES (12,'"Недавно именно так я изобрёл вечный двигатель! Чистая правда в фильме, почему он назван "фантастикой", это же полнейший реализм!
Вот цитата. Но зачем ему часы в уборной?!
— В тот день я изобрёл путешествие во времени! Как сейчас помню… Я стоял на унитазе и вешал часы. Вдруг подскользнулся, ударился головой о раковину"',8,101,14,'2019-09-24T21:08:21.567Z');
INSERT INTO "api_review_review" VALUES (13,'"Великий фильм, жаль только, что будущее, которое в нём показано, уже в прошлом. Но проблемы всё теже, вот как эта, например: «Док, послушай, всё, что нам нужно — это немного плутония!»
Всегда не хватает какой-нибудь мелочи. Семёрка за то, что будущее оказалось не таким, как обещали."',7,102,14,'2019-09-24T21:08:21.567Z');
INSERT INTO "api_review_review" VALUES (14,'"Будущее выглядит странно и неожиданно, тоже мне, бином Ньютона. Но диалог прекрасен, и за это не стану сильно минусовать.
-- Then tell me, future boy, who''s President of the United States in 1985?
-- Ronald Reagan.
-- Ronald Reagan? The actor? Then who''s vice president? Jerry Lewis?"',4,103,14,'2019-09-24T21:08:21.567Z');
INSERT INTO "api_review_review" VALUES (15,'Неужели из тюрьмы так легко было сбежать? Раз - и ты на свободе. Да, побег из Шоушенка пришлось готовить немного дольше. Пять за соцреализм',5,104,17,'2019-09-24T21:08:21.567Z');
INSERT INTO "api_review_review" VALUES (16,'Сходила в кино, решила написать: драйв и огонь, но иногда какой-то бред на экране. В середине фильма просто отличные диалоги! Пусть будет 7',7,100,3,'2019-09-24T21:08:21.567Z');
INSERT INTO "api_review_review" VALUES (17,'Смотрел, не отрываясь, хочу описать свои впечатления. По моему мнению, сценарий подкачал, зато подбор актёров - супер. Начало немного затянуто. Оператору - Оскара! Всё остальное - не очень. Фильм тянет на 8 из 10',8,101,3,'2019-09-24T21:08:21.567Z');
INSERT INTO "api_review_review" VALUES (18,'Скачал, посмотрел, думаю, что актёры так себе, сценарий хороший. Диалоги прекрасные, так что пусть будет восемь звезд',8,102,4,'2019-09-24T21:08:21.567Z');
INSERT INTO "api_review_review" VALUES (19,'Посмотрел. По моему мнению, актёры так себе, но сценарий хороший. Первую половину фильма можно спать, не опасаясь, что что-то пропустишь. Не раздумывая, ставлю уверенную десятку',10,103,4,'2019-09-24T21:08:21.567Z');
INSERT INTO "api_review_review" VALUES (20,'Скажу тем, кто ещё не смотрел: если бы я был режиссёром этого фильма - я бы не гордился. Оператора уволить, фильм получился так себе, но один раз посмотреть - сойдёт. Авторы честно заслужили 5 из 10',5,104,7,'2019-09-24T21:08:21.567Z');
INSERT INTO "api_review_review" VALUES (21,'Скачал, посмотрел, думаю, что сценарий подкачал, зато подбор актёров - супер. Начало немного затянуто, да и вообще не очень. Фильм едва тянет на 4',4,100,7,'2019-09-24T21:08:21.567Z');
INSERT INTO "api_review_review" VALUES (22,'Мне кажется, что я впустую потерял время. Ставлю 2',2,101,8,'2019-09-24T21:08:21.567Z');
INSERT INTO "api_review_review" VALUES (23,'Посмотрела. Актёры так себе, сценарий хороший. Уснула к середине. Не раздумывая, ставлю двойку',2,102,8,'2019-09-24T21:08:21.567Z');
INSERT INTO "api_review_review" VALUES (24,'Все очень долго ждали премьеру фильма,и наконец дождались.Фильм отличный,добрый,смотрится почти на одном дыхании,с завязанным сюжетом и не менее крутой музыкой.Кино очень понравилось!!!Всем советую.',10,103,9,'2019-09-24T21:08:21.567Z');
INSERT INTO "api_review_review" VALUES (25,'Отстой-фильм. Не ходите',1,104,9,'2019-09-24T21:08:21.567Z');
INSERT INTO "api_review_review" VALUES (26,'Для людей, которые хотят посмеяться и получить море эмоций, тот самый фильм. Мне очень понравился.',10,100,9,'2019-09-24T21:08:21.567Z');
INSERT INTO "api_review_review" VALUES (27,'Первый раз в жизни решила написать отзыв,чтобы предостеречь от потери денег на билет и траты времени на просмотр. К игре актеров претензий нет',2,101,10,'2019-09-24T21:08:21.567Z');
INSERT INTO "api_review_review" VALUES (28,'2 часа смотрятся на одном дыхании. Спецэффекты на уровне фильмов Марвела. Смотрели всей семьей. Посмотрел несколько отзывов, понял , что фильм стоит посмотреть',10,102,10,'2019-09-24T21:08:21.567Z');
INSERT INTO "api_review_review" VALUES (29,'Действия персонажей вызывают постоянный вопросы - что и зачем они это делают. Логики просто нет. После половины фильма уже хочется уйти',1,103,11,'2019-09-24T21:08:21.567Z');
INSERT INTO "api_review_review" VALUES (30,'"Лучший фильм, однозначно. Шедевр. Но следует понимать, что это не кино под пиво для молодежи. Стильно снято, на одном дыхании
смотрится, персонажи великолепны"',10,104,11,'2019-09-24T21:08:21.567Z');
INSERT INTO "api_review_review" VALUES (31,'Тупее не видел, смотреть не интересно скучняк',1,100,11,'2019-09-24T21:08:21.567Z');
INSERT INTO "api_review_review" VALUES (32,'Фильм интересный,но не доработанный.Остроты сюжета не хватает',8,101,12,'2019-09-24T21:08:21.567Z');
INSERT INTO "api_review_review" VALUES (33,'Самая сильная картина за последнее время. Фильм заставляет плакать, радоваться, грустить, держит в напряжении',10,102,12,'2019-09-24T21:08:21.567Z');
INSERT INTO "api_review_review" VALUES (34,'С огромным удовольствием сходила в кинотеатр. Одноразовые фильмы, названия которых забываешь на выходе из дверей кинозала, разочаровывают. И вот настоящий, душевный, жизненный фильм. Игра акторов и сюжет бомбические.',9,103,12,'2019-09-24T21:08:21.567Z');
INSERT INTO "api_review_review" VALUES (35,'Что сказать после просмотра? Ничего. Такое ощущение, что тебя обманули, заставили смотреть за твои деньги на стену',1,104,13,'2019-09-24T21:08:21.567Z');
INSERT INTO "api_review_review" VALUES (36,'Хотелось уйти уже на двадцатой минуте. Неинтересно и нудно. Режиссура не впечатлила, ну просто неинтересно смотреть было',2,100,13,'2019-09-24T21:08:21.567Z');
INSERT INTO "api_review_review" VALUES (37,'Фильм стоит увидеть тем, кому интересно современное кино. Не скучно, не затянуто, понравилась операторская работа, некоторые сцены сделаны на хорошем уровне',8,101,13,'2019-09-24T21:08:21.567Z');
INSERT INTO "api_review_review" VALUES (38,'Муторно и тяжело. Ставлю 2',2,102,15,'2019-09-24T21:08:21.567Z');
INSERT INTO "api_review_review" VALUES (39,'Фильм не оправдал ожиданий. Сплошная каша, слабый сценарий. С трудом досмотрела до конца. Ожидала нечто такого интересного и захватывающее. Полное разочарование. Отдельные несвязные сцены, непонятные диалоги',3,103,15,'2019-09-24T21:08:21.567Z');
INSERT INTO "api_review_review" VALUES (40,'Мне фильм понравился. Все качественно,красиво. Игра актеров, в основном, очень даже. Но слишком много, для меня кровавых сцен,слабонервным просьба не смотреть',9,104,15,'2019-09-24T21:08:21.567Z');
INSERT INTO "api_review_review" VALUES (41,'"Зря потерянное время! Эмоции после просмотра, - безысходность, ничего уже не изменишь. Фильм вообще никакой!!!
И поставили его люди бездарные и никчёмные!!!"',1,100,16,'2019-09-24T21:08:21.567Z');
INSERT INTO "api_review_review" VALUES (42,'После просмотра разочарование граничит с шоком. Бездарный фильм, как предыдущий от этого же режиссера. Не рекомендую никому! Плохо, неправдоподобно, скомкано снято.',2,101,16,'2019-09-24T21:08:21.567Z');
INSERT INTO "api_review_review" VALUES (43,'Фильм мощный. Главное - не занимать чью-то позицию, а смотреть со стороны. Впервые вижу, чтобы было так детально показаны переживания и эмоции каждого героя. Все на своем месте. Актеры и графика на высоте.',10,102,16,'2019-09-24T21:08:21.567Z');
INSERT INTO "api_review_review" VALUES (44,'Если такой жанр вам по вкусу, то даже не сомневайтесь - бегом в кинотеатр! Фильм - огонь! Интересный сюжет, великолепная игра актёров, съёмки просто супер, да и спецэффекты на высоте',10,103,17,'2019-09-24T21:08:21.567Z');
INSERT INTO "api_review_review" VALUES (45,'Сюжет, мысль, философия, игра актеров, эмоции - блеск! Сюжет динамичный, игра актёров хороша, но не идеальна.',8,104,18,'2019-09-24T21:08:21.567Z');
INSERT INTO "api_review_review" VALUES (46,'Разочарованине, вытащила себя в кино, а тут такое. Реклама шла мноообещающая, а в реальности всё не то',2,100,18,'2019-09-24T21:08:21.567Z');
INSERT INTO "api_review_review" VALUES (47,'Неправдоподобный, нелогичный, бессмысленный фильм. Просто никакой, можете даже не смотреть, сути не уловите. Мне понравился',10,101,19,'2019-09-24T21:08:21.567Z');
INSERT INTO "api_review_review" VALUES (48,'Интересно продуманный фильм, цепляет необычным сюжетом. длинный, что бывает не во всех фильмах. Актёры крутые. В общем, посмотреть можно.',8,102,19,'2019-09-24T21:08:21.567Z');
INSERT INTO "api_review_review" VALUES (49,'Внимательно слежу за всеми новыми изданиями, покупаю каждое. Лучший триллер тысячелетия — это «Колобок»',10,103,20,'2019-09-24T21:08:21.567Z');
INSERT INTO "api_review_review" VALUES (50,'А вот у кипчаков «колобок» — шарик из навоза! И сказка приобретает совсем другой смысл! «Не хитри, а то навоза накушаешься!»',10,104,20,'2019-09-24T21:08:21.567Z');
INSERT INTO "api_review_review" VALUES (51,'Прочла от начала до конца, не отрываясь. Ужасная книга, чему она может научить нашу молодёжь.',1,100,21,'2019-09-24T21:08:21.567Z');
INSERT INTO "api_review_review" VALUES (52,'Суровые американские семидесятые в документальном изложении. Как автор дожил до 2005-го года — загадка. Но роман прекрасный.',10,101,21,'2019-09-24T21:08:21.567Z');
INSERT INTO "api_review_review" VALUES (53,'Многабукуф. Ниасилил. В аннотации написано — «великий роман», так что ставлю максимальную оценку',10,102,22,'2019-09-24T21:08:21.567Z');
INSERT INTO "api_review_review" VALUES (54,'Если такой жанр вам по вкусу, то даже не сомневайтесь: садитесь читать! Роман - огонь! Интересный сюжет, великолепные персонажи, небо Аустерлица и встреча с дубом',10,103,22,'2019-09-24T21:08:21.567Z');
INSERT INTO "api_review_review" VALUES (55,'Я ВиМ в школе читал (заставляли), а потом опять случайно прочёл, и оказалось, что он и правла великий, а не просто так. Не ставлю десятку только в память о школьных мучениях',8,104,22,'2019-09-24T21:08:21.567Z');
INSERT INTO "api_review_review" VALUES (56,'Ничего не понял',3,100,23,'2019-09-24T21:08:21.567Z');
INSERT INTO "api_review_review" VALUES (57,'Не понял вообще ничего',1,101,23,'2019-09-24T21:08:21.567Z');
INSERT INTO "api_review_review" VALUES (58,'Совсем непонятно, но здорово',8,102,23,'2019-09-24T21:08:21.567Z');
INSERT INTO "api_review_review" VALUES (59,'Что это было?! Десятка за уровень непонятности',10,103,23,'2019-09-24T21:08:21.567Z');
INSERT INTO "api_review_review" VALUES (60,'Детально комментировать не буду, но это шедевр',10,104,23,'2019-09-24T21:08:21.567Z');
INSERT INTO "api_review_review" VALUES (61,'Один день уместился всего в один том. Автору и книге — максимальную оценку за лаконичность',10,100,23,'2019-09-24T21:08:21.567Z');
INSERT INTO "api_review_review" VALUES (62,'Одиссей без сирен и золотого руна. Куда автор подевал классический сюжет и почему там везде Ирландия?! Деньги дерут, а корицу жалеют.',3,101,23,'2019-09-24T21:08:21.567Z');
INSERT INTO "api_review_review" VALUES (63,'Не может быть такого. Это всё придумано, автор попытался обмануть читателя, но мы, читатели, умнее его. Нас вокруг пальца не обведёшь!!',2,102,24,'2019-09-24T21:08:21.567Z');
INSERT INTO "api_review_review" VALUES (64,'Всё совершенно не так, как на самом деле, и в документальной повести это хорошо описано',9,103,24,'2019-09-24T21:08:21.567Z');
INSERT INTO "api_review_review" VALUES (65,'Если бы я только мог на минутку перестать бумкать головой по ступенькам и как следует сосредоточиться — я бы написал прекрасный отзыв. Но увы — сосредоточиться-то мне и некогда: учёба, работа. Просто поставлю пятёрку',10,104,25,'2019-09-24T21:08:21.567Z');
INSERT INTO "api_review_review" VALUES (66,'Это просто «Война и мир» для детей. Читать всем',10,100,25,'2019-09-24T21:08:21.567Z');
INSERT INTO "api_review_review" VALUES (67,'Слушаю и плачу. Плачу, но слушаю',10,101,26,'2019-09-24T21:08:21.567Z');
INSERT INTO "api_review_review" VALUES (68,'Какой-то непонятный шум. Неужели это кто-то слушает?',1,102,27,'2019-09-24T21:08:21.567Z');
INSERT INTO "api_review_review" VALUES (69,'Ничего не понятно. О чём эта песня, чему она учит?',2,103,27,'2019-09-24T21:08:21.567Z');
INSERT INTO "api_review_review" VALUES (70,'Йэн Андерсон великий!!!!!!!!1111',10,104,28,'2019-09-24T21:08:21.567Z');
INSERT INTO "api_review_review" VALUES (71,'Неужели песню про аквалангистов перевели на английский?! Ну наконец-то! Аквалангисты — это хорошо!',10,100,28,'2019-09-24T21:08:21.567Z');
INSERT INTO "api_review_review" VALUES (72,'Мы прыгали, вертелись и кружились так, что пол ходил ходуном!',10,101,29,'2019-09-24T21:08:21.567Z');
INSERT INTO "api_review_review" VALUES (73,'Это единственный риф, который я умею играть на своей супердорогой гитаре! Моя любимая песня',10,104,30,'2019-09-24T21:08:21.567Z');
INSERT INTO "api_review_review" VALUES (74,'Странно: Моцарт - австриец, а марш - турецкий. Не понимаю, как так вышло. Звучит красиво, но за географическую путаницу ставлю восемь',8,100,31,'2019-09-24T21:08:21.567Z');
INSERT INTO "api_review_review" VALUES (75,'Бах forever. Это вам не три аккорда на гитаре, как у смок он зе вотер',10,102,32,'2019-09-24T21:08:21.567Z');
INSERT INTO "api_review_comment" VALUES (1,'Ничего подобного, в фильме всё не так, и программирование тут вообще ни при чём!','2020-01-13T23:20:02.422Z',102,6);
INSERT INTO "api_review_comment" VALUES (2,'Ну надо же, не нашлось ничего лучшего, кроме как прокомментировать разговор про гамбургеры, будто в фильме ничего важнее этого нет','2020-01-13T23:20:02.422Z',101,6);
INSERT INTO "api_review_comment" VALUES (3,'Кстати, а что такое четверть фунта? В граммах это сколько?','2020-01-13T23:20:02.422Z',103,6);
INSERT INTO "api_review_comment" VALUES (4,'Вот это да, никогда не слышал об этом! Спасибо за информацию','2020-01-13T23:20:02.422Z',100,50);
INSERT INTO "api_review_comment" VALUES (5,'Почему обязательно  нужно любой разговор сводить к навозу? Хорошая детская сказка, ва вы тут пишете про какие-то субстанции неприятные. Фу таким быть.','2020-01-13T23:20:02.422Z',103,50);
INSERT INTO "api_titles_title_genre" VALUES (1,1,1);
INSERT INTO "api_titles_title_genre" VALUES (2,2,1);
INSERT INTO "api_titles_title_genre" VALUES (3,3,1);
INSERT INTO "api_titles_title_genre" VALUES (4,4,1);
INSERT INTO "api_titles_title_genre" VALUES (5,5,2);
INSERT INTO "api_titles_title_genre" VALUES (6,5,6);
INSERT INTO "api_titles_title_genre" VALUES (7,5,7);
INSERT INTO "api_titles_title_genre" VALUES (8,6,3);
INSERT INTO "api_titles_title_genre" VALUES (9,7,4);
INSERT INTO "api_titles_title_genre" VALUES (10,8,7);
INSERT INTO "api_titles_title_genre" VALUES (11,9,1);
INSERT INTO "api_titles_title_genre" VALUES (12,9,2);
INSERT INTO "api_titles_title_genre" VALUES (13,10,4);
INSERT INTO "api_titles_title_genre" VALUES (14,11,4);
INSERT INTO "api_titles_title_genre" VALUES (15,12,1);
INSERT INTO "api_titles_title_genre" VALUES (16,12,5);
INSERT INTO "api_titles_title_genre" VALUES (17,12,6);
INSERT INTO "api_titles_title_genre" VALUES (18,12,8);
INSERT INTO "api_titles_title_genre" VALUES (19,13,1);
INSERT INTO "api_titles_title_genre" VALUES (20,14,5);
INSERT INTO "api_titles_title_genre" VALUES (21,15,2);
INSERT INTO "api_titles_title_genre" VALUES (22,15,6);
INSERT INTO "api_titles_title_genre" VALUES (23,15,8);
INSERT INTO "api_titles_title_genre" VALUES (24,16,2);
INSERT INTO "api_titles_title_genre" VALUES (25,17,2);
INSERT INTO "api_titles_title_genre" VALUES (26,18,1);
INSERT INTO "api_titles_title_genre" VALUES (27,19,1);
INSERT INTO "api_titles_title_genre" VALUES (28,20,7);
INSERT INTO "api_titles_title_genre" VALUES (29,20,8);
INSERT INTO "api_titles_title_genre" VALUES (30,21,9);
INSERT INTO "api_titles_title_genre" VALUES (31,22,10);
INSERT INTO "api_titles_title_genre" VALUES (32,23,10);
INSERT INTO "api_titles_title_genre" VALUES (33,24,10);
INSERT INTO "api_titles_title_genre" VALUES (34,25,8);
INSERT INTO "api_titles_title_genre" VALUES (35,26,15);
INSERT INTO "api_titles_title_genre" VALUES (36,27,11);
INSERT INTO "api_titles_title_genre" VALUES (37,27,14);
INSERT INTO "api_titles_title_genre" VALUES (38,28,11);
INSERT INTO "api_titles_title_genre" VALUES (39,29,12);
INSERT INTO "api_titles_title_genre" VALUES (40,30,14);
INSERT INTO "api_titles_title_genre" VALUES (41,31,13);
INSERT INTO "api_titles_title_genre" VALUES (42,32,13);
INSERT INTO "api_titles_title" VALUES (1,'Побег из Шоушенка',1994,'',NULL,1);
INSERT INTO "api_titles_title" VALUES (2,'Крестный отец',1972,'',NULL,1);
INSERT INTO "api_titles_title" VALUES (3,'12 разгневанных мужчин',1957,'',NULL,1);
INSERT INTO "api_titles_title" VALUES (4,'Список Шиндлера',1993,'',NULL,1);
INSERT INTO "api_titles_title" VALUES (5,'Криминальное чтиво',1994,'',NULL,1);
INSERT INTO "api_titles_title" VALUES (6,'Хороший, плохой, злой',1966,'',NULL,1);
INSERT INTO "api_titles_title" VALUES (7,'Властелин колец: Братство кольца',2001,'',NULL,1);
INSERT INTO "api_titles_title" VALUES (8,'Бойцовский клуб',1999,'',NULL,1);
INSERT INTO "api_titles_title" VALUES (9,'Форрест Гамп',1994,'',NULL,1);
INSERT INTO "api_titles_title" VALUES (10,'Звёздные войны. Эпизод 5: Империя наносит ответный удар',1980,'',NULL,1);
INSERT INTO "api_titles_title" VALUES (11,'Властелин колец: Две крепости',2002,'',NULL,1);
INSERT INTO "api_titles_title" VALUES (12,'Матрица',1999,'',NULL,1);
INSERT INTO "api_titles_title" VALUES (13,'Пролетая над гнездом кукушки',1975,'',NULL,1);
INSERT INTO "api_titles_title" VALUES (14,'Назад в будущее',1985,'',NULL,1);
INSERT INTO "api_titles_title" VALUES (15,'Операция «Ы» и другие приключения Шурика',1965,'',NULL,1);
INSERT INTO "api_titles_title" VALUES (16,'Карты, деньги, два ствола',1998,'',NULL,1);
INSERT INTO "api_titles_title" VALUES (17,'Джентльмены удачи',1971,'',NULL,1);
INSERT INTO "api_titles_title" VALUES (18,'Джанго освобожденный',2012,'',NULL,1);
INSERT INTO "api_titles_title" VALUES (19,'Generation П',2011,'',NULL,1);
INSERT INTO "api_titles_title" VALUES (20,'Колобок',1873,'',NULL,2);
INSERT INTO "api_titles_title" VALUES (21,'Страх и ненависть в Лас-Вегасе',1971,'',NULL,2);
INSERT INTO "api_titles_title" VALUES (22,'Война и мир',1865,'',NULL,2);
INSERT INTO "api_titles_title" VALUES (23,'Улисс',1918,'',NULL,2);
INSERT INTO "api_titles_title" VALUES (24,'Generation П',1999,'',NULL,2);
INSERT INTO "api_titles_title" VALUES (25,'Винни Пух и все-все-все',1926,'',NULL,2);
INSERT INTO "api_titles_title" VALUES (26,'Стас Михайлов - Позывные на любовь',2004,'',NULL,3);
INSERT INTO "api_titles_title" VALUES (27,'Led Zeppelin — Stairway to Heaven',1971,'',NULL,3);
INSERT INTO "api_titles_title" VALUES (28,'Jethro Tull - Aqualung',1971,'',NULL,3);
INSERT INTO "api_titles_title" VALUES (29,'Elvis Presley - Blue Suede Shoes',1955,'',NULL,3);
INSERT INTO "api_titles_title" VALUES (30,'Deep Purple — Smoke on the Water',1971,'',NULL,3);
INSERT INTO "api_titles_title" VALUES (31,'Моцарт - Турецкий марш',1784,'',NULL,3);
INSERT INTO "api_titles_title" VALUES (32,'Бах. Оркестровая Сюита №2 си минор',1739,'',NULL,3);
INSERT INTO "api_titles_genre" VALUES (1,'Драма','drama');
INSERT INTO "api_titles_genre" VALUES (2,'Комедия','comedy');
INSERT INTO "api_titles_genre" VALUES (3,'Вестерн','western');
INSERT INTO "api_titles_genre" VALUES (4,'Фэнтези','fantasy');
INSERT INTO "api_titles_genre" VALUES (5,'Фантастика','sci-fi');
INSERT INTO "api_titles_genre" VALUES (6,'Детектив','detective');
INSERT INTO "api_titles_genre" VALUES (7,'Триллер','thriller');
INSERT INTO "api_titles_genre" VALUES (8,'Сказка','tale');
INSERT INTO "api_titles_genre" VALUES (9,'Гонзо','gonzo');
INSERT INTO "api_titles_genre" VALUES (10,'Роман','roman');
INSERT INTO "api_titles_genre" VALUES (11,'Баллада','ballad');
INSERT INTO "api_titles_genre" VALUES (12,'Rock-n-roll','rock-n-roll');
INSERT INTO "api_titles_genre" VALUES (13,'Классика','classical');
INSERT INTO "api_titles_genre" VALUES (14,'Рок','rock');
INSERT INTO "api_titles_genre" VALUES (15,'Шансон','chanson');
INSERT INTO "api_titles_category" VALUES (1,'Фильм','movie');
INSERT INTO "api_titles_category" VALUES (2,'Книга','book');
INSERT INTO "api_titles_category" VALUES (3,'Музыка','music');
INSERT INTO "api_user_user" VALUES (10,'pbkdf2_sha256$180000$63DCTkNZmyBV$/NPh22I6Bt2ELjusJ1n+ejRlnj8nfurZzskXCaQBNUM=','2020-10-02 16:47:07.277507',1,'','',1,1,'2020-10-02 16:46:46.017244','admin',NULL,'meat9@yandex.ru',NULL,'12345678');
INSERT INTO "api_user_user" VALUES (100,'',NULL,0,'','',0,1,'','user',NULL,'bingobongo@yamdb.fake','bingobongo','12345678');
INSERT INTO "api_user_user" VALUES (101,'',NULL,0,'','',1,1,'','admin',NULL,'capt_obvious@yamdb.fake','capt_obvious','12345678');
INSERT INTO "api_user_user" VALUES (102,'',NULL,0,'','',0,1,'','user',NULL,'faust@yamdb.fake','faust','12345678');
INSERT INTO "api_user_user" VALUES (103,'',NULL,0,'','',0,1,'','user',NULL,'reviewer@yamdb.fake','reviewer','12345678');
INSERT INTO "api_user_user" VALUES (104,'',NULL,0,'','',1,1,'','moderator',NULL,'angry@yamdb.fake','angry','12345678');
INSERT INTO "auth_permission" VALUES (1,1,'add_user','Can add user');
INSERT INTO "auth_permission" VALUES (2,1,'change_user','Can change user');
INSERT INTO "auth_permission" VALUES (3,1,'delete_user','Can delete user');
INSERT INTO "auth_permission" VALUES (4,1,'view_user','Can view user');
INSERT INTO "auth_permission" VALUES (5,2,'add_logentry','Can add log entry');
INSERT INTO "auth_permission" VALUES (6,2,'change_logentry','Can change log entry');
INSERT INTO "auth_permission" VALUES (7,2,'delete_logentry','Can delete log entry');
INSERT INTO "auth_permission" VALUES (8,2,'view_logentry','Can view log entry');
INSERT INTO "auth_permission" VALUES (9,3,'add_permission','Can add permission');
INSERT INTO "auth_permission" VALUES (10,3,'change_permission','Can change permission');
INSERT INTO "auth_permission" VALUES (11,3,'delete_permission','Can delete permission');
INSERT INTO "auth_permission" VALUES (12,3,'view_permission','Can view permission');
INSERT INTO "auth_permission" VALUES (13,4,'add_group','Can add group');
INSERT INTO "auth_permission" VALUES (14,4,'change_group','Can change group');
INSERT INTO "auth_permission" VALUES (15,4,'delete_group','Can delete group');
INSERT INTO "auth_permission" VALUES (16,4,'view_group','Can view group');
INSERT INTO "auth_permission" VALUES (17,5,'add_contenttype','Can add content type');
INSERT INTO "auth_permission" VALUES (18,5,'change_contenttype','Can change content type');
INSERT INTO "auth_permission" VALUES (19,5,'delete_contenttype','Can delete content type');
INSERT INTO "auth_permission" VALUES (20,5,'view_contenttype','Can view content type');
INSERT INTO "auth_permission" VALUES (21,6,'add_session','Can add session');
INSERT INTO "auth_permission" VALUES (22,6,'change_session','Can change session');
INSERT INTO "auth_permission" VALUES (23,6,'delete_session','Can delete session');
INSERT INTO "auth_permission" VALUES (24,6,'view_session','Can view session');
INSERT INTO "auth_permission" VALUES (25,7,'add_category','Can add category');
INSERT INTO "auth_permission" VALUES (26,7,'change_category','Can change category');
INSERT INTO "auth_permission" VALUES (27,7,'delete_category','Can delete category');
INSERT INTO "auth_permission" VALUES (28,7,'view_category','Can view category');
INSERT INTO "auth_permission" VALUES (29,8,'add_genre','Can add genre');
INSERT INTO "auth_permission" VALUES (30,8,'change_genre','Can change genre');
INSERT INTO "auth_permission" VALUES (31,8,'delete_genre','Can delete genre');
INSERT INTO "auth_permission" VALUES (32,8,'view_genre','Can view genre');
INSERT INTO "auth_permission" VALUES (33,9,'add_title','Can add title');
INSERT INTO "auth_permission" VALUES (34,9,'change_title','Can change title');
INSERT INTO "auth_permission" VALUES (35,9,'delete_title','Can delete title');
INSERT INTO "auth_permission" VALUES (36,9,'view_title','Can view title');
INSERT INTO "auth_permission" VALUES (37,10,'add_review','Can add review');
INSERT INTO "auth_permission" VALUES (38,10,'change_review','Can change review');
INSERT INTO "auth_permission" VALUES (39,10,'delete_review','Can delete review');
INSERT INTO "auth_permission" VALUES (40,10,'view_review','Can view review');
INSERT INTO "auth_permission" VALUES (41,11,'add_comment','Can add comment');
INSERT INTO "auth_permission" VALUES (42,11,'change_comment','Can change comment');
INSERT INTO "auth_permission" VALUES (43,11,'delete_comment','Can delete comment');
INSERT INTO "auth_permission" VALUES (44,11,'view_comment','Can view comment');
INSERT INTO "django_content_type" VALUES (1,'api_user','user');
INSERT INTO "django_content_type" VALUES (2,'admin','logentry');
INSERT INTO "django_content_type" VALUES (3,'auth','permission');
INSERT INTO "django_content_type" VALUES (4,'auth','group');
INSERT INTO "django_content_type" VALUES (5,'contenttypes','contenttype');
INSERT INTO "django_content_type" VALUES (6,'sessions','session');
INSERT INTO "django_content_type" VALUES (7,'api_titles','category');
INSERT INTO "django_content_type" VALUES (8,'api_titles','genre');
INSERT INTO "django_content_type" VALUES (9,'api_titles','title');
INSERT INTO "django_content_type" VALUES (10,'api_review','review');
INSERT INTO "django_content_type" VALUES (11,'api_review','comment');
INSERT INTO "django_migrations" VALUES (1,'contenttypes','0001_initial','2020-10-01 17:06:52.908323');
INSERT INTO "django_migrations" VALUES (2,'contenttypes','0002_remove_content_type_name','2020-10-01 17:06:52.936324');
INSERT INTO "django_migrations" VALUES (3,'auth','0001_initial','2020-10-01 17:06:52.960323');
INSERT INTO "django_migrations" VALUES (4,'auth','0002_alter_permission_name_max_length','2020-10-01 17:06:52.973325');
INSERT INTO "django_migrations" VALUES (5,'auth','0003_alter_user_email_max_length','2020-10-01 17:06:52.991327');
INSERT INTO "django_migrations" VALUES (6,'auth','0004_alter_user_username_opts','2020-10-01 17:06:53.010326');
INSERT INTO "django_migrations" VALUES (7,'auth','0005_alter_user_last_login_null','2020-10-01 17:06:53.030327');
INSERT INTO "django_migrations" VALUES (8,'auth','0006_require_contenttypes_0002','2020-10-01 17:06:53.039331');
INSERT INTO "django_migrations" VALUES (9,'auth','0007_alter_validators_add_error_messages','2020-10-01 17:06:53.054324');
INSERT INTO "django_migrations" VALUES (10,'auth','0008_alter_user_username_max_length','2020-10-01 17:06:53.079327');
INSERT INTO "django_migrations" VALUES (11,'auth','0009_alter_user_last_name_max_length','2020-10-01 17:06:53.097324');
INSERT INTO "django_migrations" VALUES (12,'auth','0010_alter_group_name_max_length','2020-10-01 17:06:53.117324');
INSERT INTO "django_migrations" VALUES (13,'auth','0011_update_proxy_permissions','2020-10-01 17:06:53.129328');
INSERT INTO "django_migrations" VALUES (14,'api_user','0001_initial','2020-10-01 17:06:53.153327');
INSERT INTO "django_migrations" VALUES (15,'admin','0001_initial','2020-10-01 17:06:53.177330');
INSERT INTO "django_migrations" VALUES (16,'admin','0002_logentry_remove_auto_add','2020-10-01 17:06:53.203325');
INSERT INTO "django_migrations" VALUES (17,'admin','0003_logentry_add_action_flag_choices','2020-10-01 17:06:53.227326');
INSERT INTO "django_migrations" VALUES (18,'api_titles','0001_initial','2020-10-01 17:06:53.251325');
INSERT INTO "django_migrations" VALUES (19,'api_review','0001_initial','2020-10-01 17:06:53.301322');
INSERT INTO "django_migrations" VALUES (20,'api_review','0002_auto_20201001_2006','2020-10-01 17:06:53.323343');
INSERT INTO "django_migrations" VALUES (21,'sessions','0001_initial','2020-10-01 17:06:53.340341');
CREATE INDEX IF NOT EXISTS "django_session_expire_date_a5c62663" ON "django_session" (
	"expire_date"
);
CREATE INDEX IF NOT EXISTS "api_review_review_title_id_0940f808" ON "api_review_review" (
	"title_id"
);
CREATE INDEX IF NOT EXISTS "api_review_review_author_id_cd1d3b60" ON "api_review_review" (
	"author_id"
);
CREATE INDEX IF NOT EXISTS "api_review_comment_review_id_b5924c61" ON "api_review_comment" (
	"review_id"
);
CREATE INDEX IF NOT EXISTS "api_review_comment_author_id_b0b45571" ON "api_review_comment" (
	"author_id"
);
CREATE INDEX IF NOT EXISTS "api_titles_title_genre_genre_id_488b9243" ON "api_titles_title_genre" (
	"genre_id"
);
CREATE INDEX IF NOT EXISTS "api_titles_title_genre_title_id_13e05777" ON "api_titles_title_genre" (
	"title_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "api_titles_title_genre_title_id_genre_id_9f832420_uniq" ON "api_titles_title_genre" (
	"title_id",
	"genre_id"
);
CREATE INDEX IF NOT EXISTS "api_titles_title_category_id_d36b6b7d" ON "api_titles_title" (
	"category_id"
);
CREATE INDEX IF NOT EXISTS "django_admin_log_user_id_c564eba6" ON "django_admin_log" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "django_admin_log_content_type_id_c4bce8eb" ON "django_admin_log" (
	"content_type_id"
);
CREATE INDEX IF NOT EXISTS "api_user_user_user_permissions_permission_id_ea183c96" ON "api_user_user_user_permissions" (
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "api_user_user_user_permissions_user_id_94440325" ON "api_user_user_user_permissions" (
	"user_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "api_user_user_user_permissions_user_id_permission_id_a0e8b4a8_uniq" ON "api_user_user_user_permissions" (
	"user_id",
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "api_user_user_groups_group_id_2fc8afe0" ON "api_user_user_groups" (
	"group_id"
);
CREATE INDEX IF NOT EXISTS "api_user_user_groups_user_id_012753a3" ON "api_user_user_groups" (
	"user_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "api_user_user_groups_user_id_group_id_1565cf35_uniq" ON "api_user_user_groups" (
	"user_id",
	"group_id"
);
CREATE INDEX IF NOT EXISTS "auth_permission_content_type_id_2f476e4b" ON "auth_permission" (
	"content_type_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_permission_content_type_id_codename_01ab375a_uniq" ON "auth_permission" (
	"content_type_id",
	"codename"
);
CREATE INDEX IF NOT EXISTS "auth_group_permissions_permission_id_84c5c92e" ON "auth_group_permissions" (
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "auth_group_permissions_group_id_b120cbf9" ON "auth_group_permissions" (
	"group_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_group_permissions_group_id_permission_id_0cd325b0_uniq" ON "auth_group_permissions" (
	"group_id",
	"permission_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "django_content_type_app_label_model_76bd3d3b_uniq" ON "django_content_type" (
	"app_label",
	"model"
);
COMMIT;
