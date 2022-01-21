protocol ApplicationFactory {

    func getCoordinatorFactory() -> CoordinatorFactoryImp
    func getModuleFactory() -> ModuleFactoryImp
    func getServiceFactory() -> ServiceFactory
}
