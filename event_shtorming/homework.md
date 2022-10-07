# Homework 1

[Link to Miro board](https://miro.com/welcomeonboard/YjByOUkxdUlWbmYxbHFqSUplZzc0WklzVWdpY0FMV0piSDBubWpOQ1FqelhSRjhXaFZ4V2lNcFc1N1B4SmNrU3wzNDU4NzY0NTM0ODkwOTI3NDMxfDI=?share_link_id=223918405173)

### Services

*Auth* - UberPopug Inc. Auth Siper Puper Mega System с аутентификацией по форме клюва
*Tasks Tracker* - Все что связано с создание и асайном задач
*Accounting* - Отвечеает за транзакции и баланс
*Analytic* - Просто собираем данные, чтоб что-то анализировать

### Business Events

| Event | Producer | Consumer |
| - | - | - |
| Created Task | Tasks Tracker | Tasks Tracker, Accounting, Analytic |
| Assgined Tasks | Tasks Tracker | Tasks Tracker |
| Assigned task to popug | Tasks Tracker | Accounting |
| Finished task | Tasks Tracker | Accounting |
| Verified daily balance | Accounting | Mailing, Payment |
| Paid Salary | Payment | Accounting |

### CUD Events

| Event | Producer | Consumer |
| - | - | - |
| Add, Update Popug | Auth | Tasks Tracker, Accounting, Analytic |
| Delete Popug | Auth | Tasks Tracker, Accounting |
| Generated Task Prices | Accounting | Analytic |
| Changed task status | Tasks Tracker | Analytic |
| Changed manager balance | Accounting | Analytic |
| Changed popug balance | Accounting | Analytic |

### DataModel

Модель данных, уже разбитая по доменам. Одмн комментарий тут: я пока что не продумывал то, так собираюсь трекать и хранить баланс. Скорее всего это будет какая-нибудь таблица с транзакциями, но пока что обозначил просто как: Balance и Audit Log

### EventShtorming

К пул пеквесту прикрепил общий скриншот модели, а так же отдельно скриншоты доменов Tack Tracker и Accounting. Так же сверху прикрепил ссылку на miro.
