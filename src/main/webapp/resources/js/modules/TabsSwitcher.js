class TabsSwitcher extends Module {
    constructor(selector, defaultId, contentSelector, linksSelector) {
        super(selector);
        this.defaultId = defaultId;
        this.contentSelector = contentSelector;
        this.linksSelector = linksSelector;
    }

    onBindEvents() {
        this.container.addEventListener('click', (e)=>{
            this.openTab(e);
        });
    }

    onCreate() {
        this.defaultTab();
    }

    defaultTab() {
        const defaultTab = document.getElementById(this.defaultId);
        const contentName = defaultTab.getAttribute('data-content');
        const btnBg = defaultTab.getAttribute('data-color');
        const tabContent = this.container.querySelectorAll(this.contentSelector);
        const tabLinks = this.container.querySelectorAll(this.linksSelector);
        tabContent.forEach((c)=>{
           c.style.display = 'none';
        });
        tabLinks.forEach((l)=>{
           l.style.backgroundColor = '';
        });
        document.getElementById(contentName).style.display = 'block';
        defaultTab.style.backgroundColor = btnBg;
    }

    openTab(e) {
        if (e.target.closest(this.linksSelector)) {
            const contentName = e.target.closest(this.linksSelector).getAttribute('data-content');
            const btnBg = e.target.closest(this.linksSelector).getAttribute('data-color');
            const tabContent = this.container.querySelectorAll(this.contentSelector);
            const tabLinks = this.container.querySelectorAll(this.linksSelector);
            tabContent.forEach((c)=>{
                c.style.display = 'none';
            });
            tabLinks.forEach((l)=>{
                l.style.backgroundColor = '';
            });
            document.getElementById(contentName).style.display = 'block';
            e.target.closest(this.linksSelector).style.backgroundColor = btnBg;
        }
    }
}