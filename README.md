Выпускной проект.

Программа представляет собой электронный словарь, содержащий список и описание монстров из настолькой ролевой игры D&D 5ed.

Данные забираются с открытого API
http://www.dnd5eapi.co/docs/

При первом запуске программы с сервера загружаются данные и сохраняются в базе данных(риалм)

При загрузке каждого элемента обновляется выходная таблица.

По таблице реализован поиск. Так же существует вкладка фильтров, которая позволяет вывести монстров определенного типа(На основном экране, можно удалить фильтр нажав на соответствующую кнопку).

Кроме того реализована возможность заносить монстров в избранное(в отдельном списке(с поиском и фильтрами))

Так же Реализован pullToRefresh, чтобы дописать новые данные с сервера

архитектура следующая

ViewContriller -> PostModel -> PostService -> DBManager 
                                                                     \ -> RequestService -> NetModel


