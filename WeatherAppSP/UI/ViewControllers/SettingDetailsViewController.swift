import UIKit

final class SettingDetailsViewController: BaseViewController {

    @IBOutlet private weak var tableView: UITableView!

    private var editBarButtonItem = UIBarButtonItem()

    private var tableViewDataSource = [SettingDetailsModel]()

    private let settingsManager = SettingsManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationItems()
        setupTableView()
        setupDataSource()
    }

    private func setupNavigationItems() {
        editBarButtonItem = UIBarButtonItem(title: "Edit",
                                                style: .plain,
                                                target: self,
                                                action: #selector(clickEditBarButton))
        navigationItem.rightBarButtonItem = editBarButtonItem

        navigationController?.navigationBar.tintColor = .white
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self

        tableView.register(cell: SettingDetailTableViewCell.self)
    }

    private func setupDataSource() {
        settingsManager.getSettingDetails().forEach { settingDetails in
            tableViewDataSource.append(settingDetails)
        }
    }

    // MARK: - other func
    @objc private func clickEditBarButton() {
        if tableView.isEditing {
            settingsManager.setSettingDetails(newSettingDetails: tableViewDataSource)
            tableView.isEditing = false
            editBarButtonItem.title = "Edit"
        } else {
            tableView.isEditing = true
            editBarButtonItem.title = "Save"
        }
    }
}

// MARK: - Extensions
extension SettingDetailsViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewDataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SettingDetailTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.setup(settingDetailsModel: tableViewDataSource[indexPath.row])
        cell.delegate = self
        return cell
    }

    // Move Cells
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView,
                   moveRowAt sourceIndexPath: IndexPath,
                   to destinationIndexPath: IndexPath) {
        let elementToMove = tableViewDataSource[sourceIndexPath.row]
        tableViewDataSource.remove(at: sourceIndexPath.row)
        tableViewDataSource.insert(elementToMove, at: destinationIndexPath.row)
    }
}

extension SettingDetailsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.size.width / TableCellViewConstants.tableViewCellHeightAspectRatio
    }

    // Hide button"remove" cell
    func tableView(_ tableView: UITableView,
                   editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }

    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}

// MARK: - SettingDetailTableViewCellDelegate
extension SettingDetailsViewController: SettingDetailTableViewCellDelegate {

    func settingDetailTableViewCell(_ cell: SettingDetailTableViewCell, didSwitchSettingTo selectionSwitch: Bool) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }

        let settingDetailsModel: SettingDetailsModel = tableViewDataSource[indexPath.row]
        settingDetailsModel.isOn = selectionSwitch
        tableViewDataSource[indexPath.row] = settingDetailsModel

        settingsManager.setSettingDetails(newSettingDetails: tableViewDataSource)
    }
}
