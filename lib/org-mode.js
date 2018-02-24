'use babel';

import OrgModeView from './org-mode-view';
import { CompositeDisposable } from 'atom';

export default {

  orgModeView: null,
  modalPanel: null,
  subscriptions: null,

  activate(state) {
    this.orgModeView = new OrgModeView(state.orgModeViewState);
    this.modalPanel = atom.workspace.addModalPanel({
      item: this.orgModeView.getElement(),
      visible: false
    });

    // Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    this.subscriptions = new CompositeDisposable();

    // Register command that toggles this view
    this.subscriptions.add(atom.commands.add('atom-workspace', {
      'org-mode:toggle': () => this.toggle()
    }));
  },

  deactivate() {
    this.modalPanel.destroy();
    this.subscriptions.dispose();
    this.orgModeView.destroy();
  },

  serialize() {
    return {
      orgModeViewState: this.orgModeView.serialize()
    };
  },

  toggle() {
    console.log('OrgMode was toggled!');
    return (
      this.modalPanel.isVisible() ?
      this.modalPanel.hide() :
      this.modalPanel.show()
    );
  }

};
