import Foundation

protocol UserData {
    var userName: String { get } //Имя пользователя
    var userCardId: String { get } //Номер карты
    var userCardPin: Int { get } //Пин-код
    var userPhone: String { get } //Номер телефона
    var userCash: Float { get set } //Наличные пользователя
    var userBankDeposit: Float { get set } //Банковский депозит
    var userPhoneBalance: Float { get set } //Баланс телефона
    var userCardBalance: Float { get set } //Баланс карты

    // инициализатор
    init(userName: String, userCardId: String, userCardPin: Int, userPhone: String, userCash: Float, userBankDeposit: Float, userPhoneBalance: Float, userCardBalance: Float)
}

// Пример реализации структуры, соответствующей протоколу UserData
struct User: UserData {
    var userName: String
    var userCardId: String
    var userCardPin: Int
    var userPhone: String
    var userCash: Float
    var userBankDeposit: Float
    var userPhoneBalance: Float
    var userCardBalance: Float

    // Реализация инициализатора, требуемого протоколом
    init(userName: String, userCardId: String, userCardPin: Int, userPhone: String, userCash: Float, userBankDeposit: Float, userPhoneBalance: Float, userCardBalance: Float) {
        self.userName = userName
        self.userCardId = userCardId
        self.userCardPin = userCardPin
        self.userPhone = userPhone
        self.userCash = userCash
        self.userBankDeposit = userBankDeposit
        self.userPhoneBalance = userPhoneBalance
        self.userCardBalance = userCardBalance
    }
}
enum UserActions {
    case ShowBalanceCard //показать баланс карты
    case ShowbalanceDeposit //показать баланс депозита
    case withdrowCard //снять наличные с карты
    case withdrowDeposit // снять наличные с депозита
    case topUpCard //пополнить карту наличными
    case topUpDeposit //пополнить депозит наличными
    case topUpPhoneCard //пополнить счет телефона картой
    case topUpPhoneCash //пополнить счет телефона наличными
    case topUpPhoneDeposit //пополнить счет с депозита
}

// Виды операций, выбранных пользователем (подтверждение выбора)
enum DescriptionTypesAvailableOperations: String {
    case showBalanceCard = "Просмотр баланса карты"
    case showBalanceDeposit = "Просмотр баланса депозита"
    case withdrowCard = "Снятие наличных с карты"
    case withdrowDeposit = "Снятие наличных с депозита"
    case topUpCard = "Пополнение карты наличными"
    case topUpDeposit = "Пополнение депозита наличными"
    case topUpPhoneCard = "Пополнение счета телефона картой"
    case topUpPhoneCash = "Пополнение счета телефона наличными"
    case topUpPhoneDeposit = "Пополнение счета телефона с баланса депозита"
}

// Способ оплаты/пополнения наличными, картой или через депозит
enum PaymentMethod {
    case cash(Float)
    case card(Float)
    case deposit(Float)
}

// Тексты ошибок
enum TextErrors: String {
    case incorrectPin = "Неверный пин-код"
    case incorrectCardNumber = "Неверный номер карты"
    case notEnoughMoney = "Недостаточно средств"
    case maxCashLimitExceeded = "Превышен лимит на снятие наличных"
    case maxCardLimitExceeded = "Превышен лимит на снятие с карты"
    case incorrectPhoneNumber = "Неверный номер телефона"
    case unknownError = "Произошла неизвестная ошибка"
}

// Протокол по работе с банком предоставляет доступ к данным пользователя зарегистрированного в банке
protocol BankApi {
    func showUserCardBalance()
    func showUserDepositBalance()
    func showUserToppedUpMobilePhoneCash(cash: Float)
    func showUserToppedUpMobilePhoneCard(card: Float)
    func showWithdrawalCard(cash: Float)
    func showWithdrawalDeposit(cash: Float)
    func showTopUpCard(cash: Float)
    func showTopUpDeposit(cash: Float)
    func showError(error: TextErrors)
 
    func checkUserPhone(phone: String) -> Bool
    func checkMaxUserCash(cash: Float) -> Bool
    func checkMaxUserCard(withdraw: Float) -> Bool
    func checkCurrentUser(userCardId: String, userCardPin: Int) -> Bool
 
    mutating func topUpPhoneBalanceCash(pay: Float)
    mutating func topUpPhoneBalanceCard(pay: Float)
    mutating func topUpPhoneBalanceDeposit(pay: Float)
    mutating func getCashFromDeposit(cash: Float)
    mutating func getCashFromCard(cash: Float)
    mutating func putCashDeposit(topUp: Float)
    mutating func putCashCard(topUp: Float)
}

// Банкомат, с которым мы работаем, имеет общедоступный интерфейс sendUserDataToBank
class ATM {
    private let userCardId: String
    private let userCardPin: Int
    private var someBank: BankApi
    private let action: UserActions
    private let paymentMethod: PaymentMethod?
    
    
    init(userCardId: String, userCardPin: Int, someBank: BankApi, action: UserActions, paymentMethod: PaymentMethod? = nil) {
        self.userCardId = userCardId
        self.userCardPin = userCardPin
        self.someBank = someBank
        self.action = action
        self.paymentMethod = paymentMethod
        
        sendUserDataToBank(userCardId: userCardId, userCardPin: userCardPin, actions: action, payment: paymentMethod)
    }
    
    public final func sendUserDataToBank(userCardId: String, userCardPin: Int, actions: UserActions, payment: PaymentMethod?) {
        if someBank.checkCurrentUser(userCardId: userCardId, userCardPin: userCardPin) {
            switch actions {
            case .ShowBalanceCard:
                someBank.showUserCardBalance()
            case .ShowbalanceDeposit:
                someBank.showUserDepositBalance()
            case .withdrowCard, .withdrowDeposit, .topUpCard, .topUpDeposit, .topUpPhoneCard, .topUpPhoneCash, .topUpPhoneDeposit:
                guard let payment = payment else {
                    someBank.showError(error: .unknownError)
                    return
                }
                
                switch payment {
                case .cash(let amount):
                    switch actions {
                    case .withdrowCard:
                        someBank.showError(error: .unknownError)
                    case .withdrowDeposit:
                        someBank.getCashFromDeposit(cash: amount)
                    case .topUpCard:
                        someBank.putCashCard(topUp: amount)
                    case .topUpDeposit:
                        someBank.putCashDeposit(topUp: amount)
                    case .topUpPhoneCash:
                        someBank.topUpPhoneBalanceCash(pay: amount)
                    default:
                        someBank.showError(error: .unknownError)
                    }
                case .card(let amount):
                    switch actions {
                    case .withdrowCard:
                        someBank.getCashFromCard(cash: amount)
                    case .topUpPhoneCard:
                        someBank.topUpPhoneBalanceCard(pay: amount)
                    default:
                        someBank.showError(error: .unknownError)
                    }
                case .deposit(let amount):
                    switch actions {
                    case .withdrowDeposit:
                        someBank.getCashFromDeposit(cash: amount)
                    case .topUpPhoneDeposit:
                        someBank.topUpPhoneBalanceDeposit(pay: amount)
                    default:
                        someBank.showError(error: .unknownError)
                    }
                }
            }
        }
    }
    
    // Реализация протокола BankApi
    class MyBank: BankApi {
        var currentUser: UserData?
        init(user: UserData? = nil) {
            self.currentUser = user
        }
        
        func showUserCardBalance() {
            guard let currentUser = currentUser else { return }
            print("Баланс карты: \(currentUser.userCardBalance)")
        }
        
        func showUserDepositBalance() {
            guard let currentUser = currentUser else { return }
            print("Баланс депозита: \(currentUser.userBankDeposit)")
        }
        
        func showUserToppedUpMobilePhoneCash(cash: Float) {
            guard let currentUser = currentUser else { return }
            print("На счет телефона зачислено: \(cash). Баланс телефона: \(currentUser.userPhoneBalance)")
        }
        
        func showUserToppedUpMobilePhoneCard(card: Float) {
            guard let currentUser = currentUser else { return }
            print("На счет телефона зачислено с карты: \(card). Баланс телефона: \(currentUser.userPhoneBalance)")
        }
        
        func showWithdrawalCard(cash: Float) {
            guard let currentUser = currentUser else { return }
            print("С карты снято: \(cash)")
        }
        
        func showWithdrawalDeposit(cash: Float) {
            guard let currentUser = currentUser else { return }
            print("С депозита снято: \(cash)")
        }
        
        func showTopUpCard(cash: Float) {
            guard let currentUser = currentUser else { return }
            print("На карту зачислено: \(cash)")
        }
        
        func showTopUpDeposit(cash: Float) {
            guard let currentUser = currentUser else { return }
            print("На депозит зачислено: \(cash)")
        }
        
        func showError(error: TextErrors) {
            print(error.rawValue)
        }
        
        func checkUserPhone(phone: String) -> Bool {
            guard let currentUser = currentUser else { return false }
            return currentUser.userPhone == phone
        }
        
        func checkMaxUserCash(cash: Float) -> Bool {
            // Максимальная сумма наличных, которую можно снять за раз - 1000
            return cash <= 1000
        }
        
        func checkMaxUserCard(withdraw: Float) -> Bool {
            // Максимальная сумма, которую можно снять с карты за раз - 500
            return withdraw <= 500
        }
        
        func checkCurrentUser(userCardId: String, userCardPin: Int) -> Bool {
            guard let user = currentUser else { return false }
            return user.userCardId == userCardId && user.userCardPin == userCardPin
        }
        
        // Методы, изменяющие баланс
        func topUpPhoneBalanceCash(pay: Float) {
            guard var user = currentUser else { return }
            user.userPhoneBalance += pay
        }
        func topUpPhoneBalanceDeposit(pay: Float) {
            guard var user = currentUser else { return }
            user.userPhoneBalance += pay
        }
        
        func topUpPhoneBalanceCard(pay: Float) {
            guard var user = currentUser else { return }
            user.userPhoneBalance += pay
            user.userCardBalance -= pay
        }
        
        func getCashFromDeposit(cash: Float) {
            guard var user = currentUser else { return }
            user.userBankDeposit -= cash
            user.userCash += cash
        }
        
        func getCashFromCard(cash: Float) {
            guard var user = currentUser else { return }
            user.userCardBalance -= cash
            user.userCash += cash
        }
        
        func putCashDeposit(topUp: Float) {
            guard var user = currentUser else { return }
            user.userBankDeposit += topUp
            user.userCash -= topUp
        }
        
        func putCashCard(topUp: Float) {
            guard var user = currentUser else { return }
            user.userCardBalance += topUp
            user.userCash -= topUp
        }
        class User: UserData {
            var userName: String
            var userCardId: String
            var userCardPin: Int
            var userPhone: String
            var userCash: Float
            var userBankDeposit: Float
            var userPhoneBalance: Float
            var userCardBalance: Float

            required init(userName: String, userCardId: String, userCardPin: Int, userPhone: String, userCash: Float, userBankDeposit: Float, userPhoneBalance: Float, userCardBalance: Float) {
                self.userName = userName
                self.userCardId = userCardId
                self.userCardPin = userCardPin
                self.userPhone = userPhone
                self.userCash = userCash
                self.userBankDeposit = userBankDeposit
                self.userPhoneBalance = userPhoneBalance
                self.userCardBalance = userCardBalance
            }
        }
    }
   
    // Создаем эзкемпляр банка
    class DemoBank: MyBank {
        override init(user: UserData? = nil) {
            super.init(user: user)
        }
    }
   
    class Program {
        static func main() {
            // Пользователь пример
            let user = User(userName: "Иван Иванов", userCardId: "123456789", userCardPin: 1234,
                             userPhone: "987654321", userCash: 1000.0, userBankDeposit: 100.0,
                             userPhoneBalance: 100.0, userCardBalance: 3000.0)

            // Экземпляр банка
            let bank = DemoBank(user: user)

            // Создаем банкомат и ассоциируем его с банком и выбранной операцией
            let atm = ATM(userCardId: "123456789", userCardPin: 1234, someBank: bank, action: .ShowBalanceCard)

            // Пополнение счета телефона через карту
            let topUpPhoneByCard = ATM(userCardId: "123456789", userCardPin: 1234, someBank: bank, action: .topUpPhoneCard, paymentMethod: .card(500))
            //Пополнение счета телефона депозитом
            let topUpPhoneByDeposit = ATM(userCardId: "123456789", userCardPin: 1234, someBank: bank, action: .topUpPhoneDeposit, paymentMethod: .deposit(700))
            // Пополнение счета телефона наличными
            let topUpPhoneByCash = ATM(userCardId: "123456789", userCardPin: 1234, someBank: bank, action: .topUpPhoneCash, paymentMethod: .cash(400))
            //
        

            // Выполнение действий
            atm.sendUserDataToBank(userCardId: "123456789", userCardPin: 1234, actions: .ShowBalanceCard, payment: nil)
            topUpPhoneByCard.sendUserDataToBank(userCardId: "123456789", userCardPin: 1234, actions: .topUpPhoneCard, payment: .card(200))
            topUpPhoneByDeposit.sendUserDataToBank(userCardId: "123456789", userCardPin: 1234, actions: .topUpPhoneDeposit, payment: .deposit(20000))
            topUpPhoneByCash.sendUserDataToBank(userCardId: "123456789", userCardPin: 1234, actions: .topUpPhoneCash, payment: .cash(400))
        }
    }
}

// Запуск основной программы
ATM.Program.main()
