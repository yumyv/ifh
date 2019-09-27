class Module {
    constructor(selector) {
        this.selector = selector;
        this.container = document.querySelector(this.selector);
    }

    init() {
        if (this.container) {
            this.onComponentsLoading();
            this.onBindEvents();
            this.onCreate()
        }
    }

    onComponentsLoading() {
    }

    onBindEvents() {
    }

    onCreate() {
    }
}