import EraLensNativeCore
import UIKit
import WebKit

final class EraLensViewController: UIViewController {
    private var webView: WKWebView!
    private var resourceHandler: EraLensResourceSchemeHandler?
    private var bridge: EraLensWebBridge?

    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(red: 0.969, green: 0.957, blue: 0.929, alpha: 1)

        guard let resources = Bundle.main.resourceURL?.appendingPathComponent("NativeResources", isDirectory: true) else {
            showStartupError("应用资源目录不存在")
            return
        }
        let handler = EraLensResourceSchemeHandler(root: resources.appendingPathComponent("Web", isDirectory: true))
        let bridge = EraLensWebBridge(platform: .ios, resourcesURL: resources) { url in
            DispatchQueue.main.async { UIApplication.shared.open(url) }
        }
        resourceHandler = handler
        self.bridge = bridge

        let configuration = WKWebViewConfiguration()
        configuration.setURLSchemeHandler(handler, forURLScheme: "eralens")
        configuration.userContentController.addScriptMessageHandler(bridge, contentWorld: .page, name: "eralensNative")
        configuration.userContentController.addUserScript(WKUserScript(source: bridge.bootstrap, injectionTime: .atDocumentStart, forMainFrameOnly: true))
        webView = WKWebView(frame: .zero, configuration: configuration)
        webView.navigationDelegate = bridge
        webView.uiDelegate = bridge
        webView.isOpaque = false
        webView.backgroundColor = view.backgroundColor
        webView.scrollView.backgroundColor = view.backgroundColor
        webView.scrollView.contentInsetAdjustmentBehavior = .never
        webView.scrollView.keyboardDismissMode = .interactive
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.keyboardLayoutGuide.followsUndockedKeyboard = false
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor),
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        guard webView != nil else { return }
        webView.load(URLRequest(url: URL(string: "eralens://app/index.html")!))
    }

    private func showStartupError(_ message: String) {
        let label = UILabel()
        label.text = "EraLens 无法启动：\(message)"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}
