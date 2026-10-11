import AppKit
import EraLensNativeCore
import WebKit

final class EraLensApp: NSObject, NSApplicationDelegate {
    private var window: NSWindow?
    private var resourceHandler: EraLensResourceSchemeHandler?
    private var bridge: EraLensWebBridge?

    func applicationDidFinishLaunching(_ notification: Notification) {
        NSApp.setActivationPolicy(.regular)
        guard let bundleResources = Bundle.main.resourceURL else {
            showStartupError("应用资源目录不存在")
            return
        }
        let resources = bundleResources.appendingPathComponent("NativeResources", isDirectory: true)
        let handler = EraLensResourceSchemeHandler(root: resources.appendingPathComponent("Web", isDirectory: true))
        let bridge = EraLensWebBridge(platform: .mac, resourcesURL: resources) { NSWorkspace.shared.open($0) }
        self.resourceHandler = handler
        self.bridge = bridge

        let configuration = WKWebViewConfiguration()
        configuration.setURLSchemeHandler(handler, forURLScheme: "eralens")
        configuration.userContentController.addScriptMessageHandler(bridge, contentWorld: .page, name: "eralensNative")
        configuration.userContentController.addUserScript(WKUserScript(source: bridge.bootstrap, injectionTime: .atDocumentStart, forMainFrameOnly: true))
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.navigationDelegate = bridge
        webView.uiDelegate = bridge

        let window = NSWindow(contentRect: NSRect(x: 0, y: 0, width: 1280, height: 820),
                              styleMask: [.titled, .closable, .miniaturizable, .resizable],
                              backing: .buffered, defer: false)
        window.title = "EraLens · 历史透镜"
        window.minSize = NSSize(width: 800, height: 600)
        window.center()
        window.contentView = webView
        self.window = window
        installMainMenu()
        window.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
        webView.load(URLRequest(url: URL(string: "eralens://app/index.html")!))
    }

    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows: Bool) -> Bool {
        if !hasVisibleWindows { window?.makeKeyAndOrderFront(nil) }
        return true
    }

    private func showStartupError(_ message: String) {
        let alert = NSAlert()
        alert.messageText = "EraLens 无法启动"
        alert.informativeText = message
        alert.runModal()
        NSApp.terminate(nil)
    }

    private func installMainMenu() {
        let menu = NSMenu()
        let appItem = NSMenuItem()
        let appMenu = NSMenu()
        appMenu.addItem(NSMenuItem(title: "关于 EraLens", action: #selector(NSApplication.orderFrontStandardAboutPanel(_:)), keyEquivalent: ""))
        appMenu.addItem(.separator())
        appMenu.addItem(NSMenuItem(title: "退出 EraLens", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
        appItem.submenu = appMenu
        menu.addItem(appItem)

        let editItem = NSMenuItem()
        let editMenu = NSMenu(title: "编辑")
        editMenu.addItem(NSMenuItem(title: "撤销", action: Selector(("undo:")), keyEquivalent: "z"))
        editMenu.addItem(NSMenuItem(title: "重做", action: Selector(("redo:")), keyEquivalent: "Z"))
        editMenu.addItem(.separator())
        editMenu.addItem(NSMenuItem(title: "剪切", action: #selector(NSText.cut(_:)), keyEquivalent: "x"))
        editMenu.addItem(NSMenuItem(title: "拷贝", action: #selector(NSText.copy(_:)), keyEquivalent: "c"))
        editMenu.addItem(NSMenuItem(title: "粘贴", action: #selector(NSText.paste(_:)), keyEquivalent: "v"))
        editMenu.addItem(NSMenuItem(title: "全选", action: #selector(NSText.selectAll(_:)), keyEquivalent: "a"))
        editItem.submenu = editMenu
        menu.addItem(editItem)

        let windowItem = NSMenuItem()
        let windowMenu = NSMenu(title: "窗口")
        windowMenu.addItem(NSMenuItem(title: "最小化", action: #selector(NSWindow.performMiniaturize(_:)), keyEquivalent: "m"))
        windowMenu.addItem(NSMenuItem(title: "缩放", action: #selector(NSWindow.performZoom(_:)), keyEquivalent: ""))
        windowItem.submenu = windowMenu
        menu.addItem(windowItem)
        NSApp.mainMenu = menu
    }
}

@main
enum EraLensMacMain {
    static func main() {
        let application = NSApplication.shared
        let delegate = EraLensApp()
        application.delegate = delegate
        application.run()
    }
}
