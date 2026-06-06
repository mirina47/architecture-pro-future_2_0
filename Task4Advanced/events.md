# Каталог доменных событий системы «Будущее 2.0»

## Patient Context

| Название | Контекст-источник | Семантика | Минимальный контракт |
|---|---|---|---|
| `PatientRegistered` | Patient Context | Пациент зарегистрирован в системе | `patientId`, `timestamp` |
| `PatientUpdated` | Patient Context | Изменены персональные или контактные данные пациента | `patientId`, `changedFields`, `timestamp` |
| `PatientDeactivated` | Patient Context | Пациент переведён в неактивный статус | `patientId`, `reason`, `timestamp` |

## Clinical Context

| Название | Контекст-источник | Семантика | Минимальный контракт |
|---|---|---|---|
| `AppointmentCreated` | Clinical Context | Создана запись на приём | `appointmentId`, `patientId`, `doctorId`, `startTime` |
| `AppointmentCompleted` | Clinical Context | Приём завершён (пациент принят) | `appointmentId`, `endTime` |
| `ServiceRendered` | Clinical Context | В рамках приёма оказана медицинская услуга | `appointmentId`, `serviceCode`, `cost` |
| `StudyRequested` | Clinical Context | Назначено исследование (МРТ, КТ, анализ) | `studyId`, `patientId`, `studyType`, `urgency` |

## AI Diagnostics Context

| Название | Контекст-источник | Семантика | Минимальный контракт |
|---|---|---|---|
| `DiagnosisReady` | AI Diagnostics Context | ИИ подготовил диагноз по исследованию | `studyId`, `diagnosisCode`, `confidence` |
| `ImageAnalyzed` | AI Diagnostics Context | Анализ медицинского снимка завершён | `imageId`, `findings`, `probability` |

## Finance Context

| Название | Контекст-источник | Семантика | Минимальный контракт |
|---|---|---|---|
| `LoanCreated` | Finance Context | Создан кредитный договор | `loanId`, `patientId`, `amount`, `rate`, `term` |
| `LoanApproved` | Finance Context | Кредит одобрен | `loanId`, `approvedAt` |
| `PaymentProcessed` | Finance Context | Проведён платёж (по кредиту или услуге) | `paymentId`, `amount`, `date`, `status` |
| `BalanceChanged` | Finance Context | Изменён баланс счёта клиента | `accountId`, `newBalance`, `delta` |

## Data Platform Context

| Название | Контекст-источник | Семантика | Минимальный контракт |
|---|---|---|---|
| `DataProductPublished` | Data Platform Context | Опубликован новый дата-продукт в каталоге | `dataProductId`, `owner`, `schema` |
| `ReportUpdated` | Data Platform Context | Сформирован или обновлён отчёт | `reportId`, `generatedAt`, `status` |