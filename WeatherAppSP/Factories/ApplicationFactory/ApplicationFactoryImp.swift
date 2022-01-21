final class ApplicationFactoryImp: ApplicationFactory {

    private var сoordinatorFactory = CoordinatorFactoryImp()
    private var moduleFactory = ModuleFactoryImp()
    private var serviceFactory = ServiceFactoryImp()

    func getCoordinatorFactory() -> CoordinatorFactoryImp {
        return сoordinatorFactory
    }

    func getModuleFactory() -> ModuleFactoryImp {
        return moduleFactory
    }

    func getServiceFactory() -> ServiceFactory {
        return serviceFactory
    }
}
