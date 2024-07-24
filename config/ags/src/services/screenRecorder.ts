
import Gio from 'gi://Gio';
import GLib from 'gi://GLib';

function loadInterfaceXML(iface: string) {
  const uri = `resource:///com/github/Aylur/ags/dbus/${iface}.xml`;
  const f = Gio.File.new_for_uri(uri);

  try {
    const [, bytes] = f.load_contents(null);
    return new TextDecoder().decode(bytes);
  } catch (e) {
    logError(e);
    return null;
  }
}

const DBUS_PATH = ['dev', 'c777', 'screenRecorderStatus'];
const ScreenRecorderStatusIFace = loadInterfaceXML(DBUS_PATH.join('.'));


export class ScreenRecorderStatus extends Service {
  static {
    Service.register(this, {
      'dismissed': ['int'],
      'notified': ['int'],
      'closed': ['int'],
    }, {
      'notifications': ['jsobject'],
      'popups': ['jsobject'],
      'dnd': ['boolean'],
    });
  }

  private _dbus!: Gio.DBusExportedObject;

  constructor() {
    super();

    this._register();
  }

  GetCapabilities() {
    return [
      'action-icons',
      'actions',
      'body',
      'body-hyperlinks',
      'body-markup',
      'icon-static',
      'persistence',
      'sound',
    ];
  }

  GetServerInformation() {
    return new GLib.Variant('(b)', [pkg.name, 'Aylur', pkg.version, '1.2']);
  }

  private _register() {
    Gio.bus_own_name(
      Gio.BusType.SESSION,
      DBUS_PATH.join('.'),
      Gio.BusNameOwnerFlags.NONE,
      (connection: Gio.DBusConnection) => {
        this._dbus = Gio.DBusExportedObject
          .wrapJSObject(ScreenRecorderStatusIFace as string, this);

        this._dbus.export(connection, DBUS_PATH.join('/'));
      },
      () => { },
      () => {
        const [name] = Gio.DBus.session.call_sync(
          DBUS_PATH.join('.'),
          DBUS_PATH.join('/'),
          DBUS_PATH.join('.'),
          'GetServerInformation',
          null,
          null,
          Gio.DBusCallFlags.NONE,
          -1,
          null).deepUnpack() as string[];

        console.warn(`Another ScreenRecorderStatus daemon is already running: ${name}`);
      },
    );
  }
}

export const screenRecorderStatus = new ScreenRecorderStatus;
export default screenRecorderStatus;
