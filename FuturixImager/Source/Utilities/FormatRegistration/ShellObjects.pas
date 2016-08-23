unit ShellObjects;

{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
{$ALIGN 4}
interface

uses Windows, ActiveX, Classes, Graphics, Variants;
  
const
  ShellObjectsMajorVersion = 1;
  ShellObjectsMinorVersion = 0;

  LIBID_ShellObjects: TGUID = '{50A7E9B1-70EF-11D1-B75A-00A0C90564FE}';

  IID_IShellFolder: TGUID = '{000214E6-0000-0000-C000-000000000046}';
  IID_IShellFolder2: TGUID = '{93F2F68C-1D1B-11D3-A30E-00C04F79ABD1}';
  CLASS_ShellDesktop: TGUID = '{00021400-0000-0000-C000-000000000046}';
  IID_IBindCtx: TGUID = '{0000000E-0000-0000-C000-000000000046}';
  IID_IRunningObjectTable: TGUID = '{00000010-0000-0000-C000-000000000046}';
  IID_IPersist: TGUID = '{0000010C-0000-0000-C000-000000000046}';
  IID_IPersistStream: TGUID = '{00000109-0000-0000-C000-000000000046}';
  IID_IMoniker: TGUID = '{0000000F-0000-0000-C000-000000000046}';
  IID_ISequentialStream: TGUID = '{0C733A30-2A1C-11CE-ADE5-00AA0044773D}';
  IID_IStream: TGUID = '{0000000C-0000-0000-C000-000000000046}';
  IID_IEnumMoniker: TGUID = '{00000102-0000-0000-C000-000000000046}';
  IID_IEnumString: TGUID = '{00000101-0000-0000-C000-000000000046}';
  IID_IEnumIDList: TGUID = '{000214F2-0000-0000-C000-000000000046}';
  IID_IEnumExtraSearch: TGUID = '{0E700BE1-9DB6-11D1-A1CE-00C04FD75D13}';
  CLASS_ShellFSFolder: TGUID = '{F3364BA0-65B9-11CE-A9BA-00AA004AE837}';
  CLASS_NetworkPlaces: TGUID = '{208D2C60-3AEA-1069-A2D7-08002B30309D}';
  IID_IShellLinkW: TGUID = '{000214F9-0000-0000-C000-000000000046}';
  CLASS_ShellLink: TGUID = '{00021401-0000-0000-C000-000000000046}';
  IID_IQueryCancelAutoPlay: TGUID = '{DDEFE873-6997-4E68-BE26-39B633ADBE12}';
  CLASS_QueryCancelAutoPlay: TGUID = '{331F1768-05A9-4DDD-B86E-DAE34DDC998A}';
  IID_ICategorizer: TGUID = '{A3B14589-9174-49A8-89A3-06A1AE2B9BA7}';
  CLASS_DriveSizeCategorizer: TGUID = '{94357B53-CA29-4B78-83AE-E8FE7409134F}';
  CLASS_DriveTypeCategorizer: TGUID = '{B0A8F3CF-4333-4BAB-8873-1CCB1CADA48B}';
  CLASS_FreeSpaceCategorizer: TGUID = '{B5607793-24AC-44C7-82E2-831726AA6CB7}';
  CLASS_TimeCategorizer: TGUID = '{3BB4118F-DDFD-4D30-A348-9FB5D6BF1AFE}';
  CLASS_SizeCategorizer: TGUID = '{55D7B852-F6D1-42F2-AA75-8728A1B2D264}';
  CLASS_AlphabeticalCategorizer: TGUID = '{3C2654C6-7372-4F6B-B310-55D6128F49D2}';
  CLASS_MergedCategorizer: TGUID = '{8E827C11-33E7-4BC1-B242-8CD9A1C2B304}';
  IID_IPersistFile: TGUID = '{0000010B-0000-0000-C000-000000000046}';
  CLASS_ImageProperties: TGUID = '{7AB770C7-0E23-4D7A-8AA2-19BFAD479829}';
  IID_IPropertyUI: TGUID = '{757A7D9F-919A-4118-99D7-DBB208C8CC66}';
  CLASS_PropertiesUI: TGUID = '{D912F8CF-0396-4915-884E-FB425D32943B}';
  IID_IStorage: TGUID = '{0000000B-0000-0000-C000-000000000046}';
  IID_IEnumSTATSTG: TGUID = '{0000000D-0000-0000-C000-000000000046}';
  IID_IRecordInfo: TGUID = '{0000002F-0000-0000-C000-000000000046}';
  IID_ITypeInfo: TGUID = '{00020401-0000-0000-C000-000000000046}';
  IID_ITypeComp: TGUID = '{00020403-0000-0000-C000-000000000046}';
  IID_ITypeLib: TGUID = '{00020402-0000-0000-C000-000000000046}';
  IID_IUserNotification: TGUID = '{BA9711BA-5893-4787-A7E1-41277151550B}';
  CLASS_UserNotification: TGUID = '{0010890E-8789-413C-ADBC-48F5B511B3AF}';
  IID_IQueryContinue: TGUID = '{7307055C-B24A-486B-9F25-163E597A28A9}';
  IID_ICDBurn: TGUID = '{3D73A659-E5D0-4D42-AFC0-5121BA425C8D}';
  CLASS_CDBurn: TGUID = '{FBEB8A05-BEEE-4442-804E-409D6C4515E9}';
  IID_ITaskbarList: TGUID = '{56FDF342-FD6D-11D0-958A-006097C9A090}';
  IID_ITaskbarList2: TGUID = '{602D4995-B13A-429B-A66E-1935E44F4317}';
  IID_ITaskbarList3: TGUID = '{EA1AFB91-9E28-4B86-90E9-9E9F8A5EEFAF}';
  IID_ITaskbarList4: TGUID = '{C43DC798-95D1-4BEA-9030-BB99E2983A1A}';
  CLASS_TaskbarList: TGUID = '{56FDF344-FD6D-11D0-958A-006097C9A090}';
  IID_IStartMenuPinnedList: TGUID = '{4CD19ADA-25A5-4A32-B3B7-347BEE5BE36B}';
  CLASS_StartMenuPin: TGUID = '{A2A9545D-A0C2-42B4-9708-A0B2BADD77C8}';
  IID_IShellItem: TGUID = '{43826D1E-E718-42EE-BC55-A1E261C37BFE}';
  IID_IWizardExtension: TGUID = '{C02EA696-86CC-491E-9B23-74394A0444A8}';
  IID_IWebWizardExtension: TGUID = '{0E6B3F66-98D1-48C0-A222-FBDE74E2FBC5}';
  CLASS_WebWizardHost: TGUID = '{C827F149-55C1-4D28-935E-57E47CAED973}';
  IID_IDropTarget: TGUID = '{00000122-0000-0000-C000-000000000046}';
  CLASS_PublishDropTarget: TGUID = '{CC6EEFFB-43F6-46C5-9619-51D571967F7D}';
  IID_IDataObject: TGUID = '{0000010E-0000-0000-C000-000000000046}';
  IID_IEnumFORMATETC: TGUID = '{00000103-0000-0000-C000-000000000046}';
  IID_IAdviseSink: TGUID = '{0000010F-0000-0000-C000-000000000046}';
  IID_IEnumSTATDATA: TGUID = '{00000105-0000-0000-C000-000000000046}';
  IID_IPublishingWizard: TGUID = '{AA9198BB-CCEC-472D-BEED-19A4F6733F7A}';
  CLASS_PublishingWizard: TGUID = '{6B33163C-76A5-4B6C-BF21-45DE9CD503A1}';
  IID_IXMLDOMNode: TGUID = '{2933BF80-7B36-11D2-B20E-00C04F983E60}';
  IID_IXMLDOMDocument: TGUID = '{2933BF81-7B36-11D2-B20E-00C04F983E60}';
  IID_IXMLDOMNodeList: TGUID = '{2933BF82-7B36-11D2-B20E-00C04F983E60}';
  IID_IXMLDOMNamedNodeMap: TGUID = '{2933BF83-7B36-11D2-B20E-00C04F983E60}';
  IID_IXMLDOMDocumentType: TGUID = '{2933BF8B-7B36-11D2-B20E-00C04F983E60}';
  IID_IXMLDOMImplementation: TGUID = '{2933BF8F-7B36-11D2-B20E-00C04F983E60}';
  IID_IXMLDOMElement: TGUID = '{2933BF86-7B36-11D2-B20E-00C04F983E60}';
  IID_IXMLDOMAttribute: TGUID = '{2933BF85-7B36-11D2-B20E-00C04F983E60}';
  IID_IXMLDOMDocumentFragment: TGUID = '{3EFAA413-272F-11D2-836F-0000F87A7782}';
  IID_IXMLDOMCharacterData: TGUID = '{2933BF84-7B36-11D2-B20E-00C04F983E60}';
  IID_IXMLDOMText: TGUID = '{2933BF87-7B36-11D2-B20E-00C04F983E60}';
  IID_IXMLDOMComment: TGUID = '{2933BF88-7B36-11D2-B20E-00C04F983E60}';
  IID_IXMLDOMCDATASection: TGUID = '{2933BF8A-7B36-11D2-B20E-00C04F983E60}';
  IID_IXMLDOMProcessingInstruction: TGUID = '{2933BF89-7B36-11D2-B20E-00C04F983E60}';
  IID_IXMLDOMEntityReference: TGUID = '{2933BF8E-7B36-11D2-B20E-00C04F983E60}';
  IID_IXMLDOMParseError: TGUID = '{3EFAA426-272F-11D2-836F-0000F87A7782}';
  CLASS_InternetPrintOrdering: TGUID = '{ADD36AA8-751A-4579-A266-D66F5202CCBB}';
  IID_IFolderViewHost: TGUID = '{1EA58F02-D55A-411D-B09E-9E65AC21605B}';
  CLASS_FolderViewHost: TGUID = '{20B1CB23-6968-4EB9-B7D4-A66D00D07CEE}';
  IID_IExplorerBrowser: TGUID = '{DFD3B6B5-C10C-4BE9-85F6-A66969F402F6}';
  CLASS_ExplorerBrowser: TGUID = '{71F96385-DDD6-48D3-A0C1-AE06E8B055FB}';
  IID_IExplorerBrowserEvents: TGUID = '{361BBDC7-E6EE-4E13-BE58-58E2240C810F}';
  IID_IOleWindow: TGUID = '{00000114-0000-0000-C000-000000000046}';
  IID_IShellView: TGUID = '{000214E3-0000-0000-C000-000000000046}';
  IID_IShellBrowser: TGUID = '{000214E2-0000-0000-C000-000000000046}';
  IID_IImageRecompress: TGUID = '{505F1513-6B3E-4892-A272-59F8889A4D3E}';
  CLASS_ImageRecompress: TGUID = '{6E33091C-D2F8-4740-B55E-2E11D1477A2C}';
  IID_IBandSite: TGUID = '{4CF504B0-DE96-11D0-8B3F-00A0C911E8E5}';
  CLASS_TrayBandSiteService: TGUID = '{F60AD0A0-E5E1-45CB-B51A-E15B9F8B2934}';
  IID_IDockingWindow: TGUID = '{012DD920-7B26-11D0-8CA9-00A0C92DBFE8}';
  IID_IDeskBand: TGUID = '{EB0FE172-1A3A-11D0-89B3-00A0C90A90AC}';
  IID_ITrayDeskBand: TGUID = '{6D67E846-5B9C-4DB8-9CBC-DDE12F4254F1}';
  CLASS_TrayDeskBand: TGUID = '{E6442437-6C68-4F52-94DD-2CFED267EFB9}';
  IID_IAttachmentExecute: TGUID = '{73DB1241-1E85-4581-8E4F-A81E1D0F8C57}';
  CLASS_AttachmentServices: TGUID = '{4125DD96-E03A-4103-8F70-E0597D803B9C}';
  IID_IShellExtInit: TGUID = '{000214E8-0000-0000-C000-000000000046}';
  CLASS_DocPropShellExtension: TGUID = '{883373C3-BF89-11D1-BE35-080036B11A03}';
  IID_IShellItem2: TGUID = '{7E9FB0D3-919F-4307-AB2E-9B1860310C93}';
  CLASS_ShellItem: TGUID = '{9AC9FBE1-E0A2-4AD6-B4EE-E212013EA917}';
  IID_INamespaceWalk: TGUID = '{57CED8A7-3F4A-432C-9350-30F24483F74F}';
  CLASS_NamespaceWalker: TGUID = '{72EB61E0-8672-4303-9175-F2E4C68B2E7C}';
  IID_INamespaceWalkCB: TGUID = '{D92995F8-CF5E-4A76-BF59-EAD39EA2B97E}';
  IID_IFileOperation: TGUID = '{947AAB5F-0A5C-4C13-B4D6-4BF7836FC9F8}';
  CLASS_FileOperation: TGUID = '{3AD05575-8857-4850-9277-11B85BDB8E09}';
  IID_IFileOperationProgressSink: TGUID = '{04B0F1A7-9490-44BC-96E1-4296A31252E2}';
  IID_IOperationsProgressDialog: TGUID = '{0C9FB851-E5C9-43EB-A370-F0677B13874C}';
  IID_IPropertyChangeArray: TGUID = '{380F5CAD-1B5E-42F2-805D-637FD392D31E}';
  IID_IObjectWithPropertyKey: TGUID = '{FC0CA0A7-C316-4FD2-9031-3E628E6D4F23}';
  IID_IPropertyChange: TGUID = '{F917BC8A-1BBA-4478-A245-1BDE03EB9431}';
  IID_IModalWindow: TGUID = '{B4DB1657-70D7-485E-8E3E-6FCB5A5C1802}';
  IID_IFileDialog: TGUID = '{42F85136-DB7E-439C-85F1-E4075D135FC8}';
  IID_IFileOpenDialog: TGUID = '{D57C7288-D4AD-4768-BE02-9D969532D960}';
  CLASS_FileOpenDialog: TGUID = '{DC1C5A9C-E88A-4DDE-A5A1-60F82A20AEF7}';
  IID_IFileDialogEvents: TGUID = '{973510DB-7D7F-452B-8975-74A85828D354}';
  IID_IShellItemFilter: TGUID = '{2659B475-EEB8-48B7-8F07-B378810F48CF}';
  IID_IShellItemArray: TGUID = '{B63EA76D-1F85-456F-A19C-48159EFA858B}';
  IID_IEnumShellItems: TGUID = '{70629033-E363-4A28-A567-0DB78006E6D7}';
  IID_IFileSaveDialog: TGUID = '{84BCCD23-5FDE-4CDB-AEA4-AF64B83D78AB}';
  CLASS_FileSaveDialog: TGUID = '{C0B4E2F3-BA21-4773-8DBA-335EC946EB8B}';
  IID_IPropertyStore: TGUID = '{886D8EEB-8CF2-4446-8D02-CDBA1DBDCF99}';
  IID_IPropertyDescriptionList: TGUID = '{1F9FC1D0-C39B-4B26-817F-011967D3440E}';
  IID_IKnownFolderManager: TGUID = '{8BE2D872-86AA-4D47-B776-32CCA40C7018}';
  CLASS_KnownFolderManager: TGUID = '{4DF0C730-DF9D-4AE3-9153-AA6B82E9795A}';
  IID_IKnownFolder: TGUID = '{3AA7AF7E-9B36-420C-A8E3-F77D4674A488}';
  CLASS_FSCopyHandler: TGUID = '{D197380A-0A79-4DC8-A033-ED882C2FA14B}';
  IID_ISharingConfigurationManager: TGUID = '{B4CD448A-9C86-4466-9201-2E62105B87AE}';
  CLASS_SharingConfigurationManager: TGUID = '{49F371E1-8C5C-4D9C-9A3B-54A6827F513C}';
  IID_IPreviousVersionsInfo: TGUID = '{76E54780-AD74-48E3-A695-3BA9A0AFF10D}';
  CLASS_PreviousVersions: TGUID = '{596AB062-B4D2-4215-9F74-E9109B0A8153}';
  CLASS_NetworkConnections: TGUID = '{7007ACC7-3202-11D1-AAD2-00805FC1270E}';
  IID_INameSpaceTreeControl: TGUID = '{028212A3-B627-47E9-8856-C14265554E4F}';
  IID_INameSpaceTreeControl2: TGUID = '{7CC7AED8-290E-49BC-8945-C1401CC9306C}';
  CLASS_NamespaceTreeControl: TGUID = '{AE054212-3535-4430-83ED-D501AA6680E6}';
  CLASS_IENamespaceTreeControl: TGUID = '{ACE52D03-E5CD-4B20-82FF-E71B11BEAE1D}';
  CLASS_ScheduledTasks: TGUID = '{D6277990-4C6A-11CF-8D87-00AA0060F5BF}';
  IID_IApplicationAssociationRegistration: TGUID = '{4E530B0A-E611-4C77-A3AC-9031D022281B}';
  CLASS_ApplicationAssociationRegistration: TGUID = '{591209C7-767B-42B2-9FBA-44EE4615F2C7}';
  IID_IApplicationAssociationRegistrationUI: TGUID = '{1F76A169-F994-40AC-8FC8-0959E8874710}';
  CLASS_ApplicationAssociationRegistrationUI: TGUID = '{1968106D-F3B5-44CF-890E-116FCB9ECEF1}';
  IID_ISearchFolderItemFactory: TGUID = '{A0FFBC28-5482-4366-BE27-3E81E78E06C2}';
  CLASS_SearchFolderItemFactory: TGUID = '{14010E02-BBBD-41F0-88E3-EDA371216584}';
  IID_ICondition: TGUID = '{0FC988D4-C935-4B97-A973-46282EA175C8}';
  IID_IRichChunk: TGUID = '{4FDEF69C-DBC9-454E-9910-B34F3C64B510}';
  IID_IOpenControlPanel: TGUID = '{D11AD862-66DE-4DF4-BF6C-1F5621996AF1}';
  CLASS_OpenControlPanel: TGUID = '{06622D85-6856-4460-8DE1-A81921B41C4B}';
  CLASS_MailRecipient: TGUID = '{9E56BE60-C50F-11CF-9A2C-00A0C90A90CE}';
  CLASS_NetworkExplorerFolder: TGUID = '{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}';
  IID_ICustomDestinationList: TGUID = '{6332DEBF-87B5-4670-90C0-5E57B408A49E}';
  CLASS_DestinationList: TGUID = '{77F10CF0-3DB5-4966-B520-B7C54FD35ED6}';
  IID_IObjectArray: TGUID = '{92CA9DCD-5622-4BBA-A805-5E9F541BD8C9}';
  IID_IApplicationDestinations: TGUID = '{12337D35-94C6-48A0-BCE7-6A9C69D4D600}';
  CLASS_ApplicationDestinations: TGUID = '{86C14003-4D6B-4EF3-A7B4-0506663B2E68}';
  IID_IApplicationDocumentLists: TGUID = '{3C594F9F-9F30-47A1-979A-C9E83D3D0A06}';
  CLASS_ApplicationDocumentLists: TGUID = '{86BEC222-30F2-47E0-9F25-60D11CD75C28}';
  IID_IHomeGroup: TGUID = '{7A3BD1D9-35A9-4FB3-A467-F48CAC35E2D0}';
  CLASS_HomeGroup: TGUID = '{DE77BA04-3C92-4D11-A1A5-42352A53E0E3}';
  IID_IShellLibrary: TGUID = '{11A66EFA-382E-451A-9234-1E0E12EF3085}';
  CLASS_ShellLibrary: TGUID = '{D9B3211D-E57F-4426-AAEF-30A806ADD397}';
  CLASS_AppStartupLink: TGUID = '{273EB5E7-88B0-4843-BFEF-E2C81D43AAE5}';
  IID_IEnumObjects: TGUID = '{2C1C7E2E-2D0E-4059-831E-1E6F82335C2E}';
  CLASS_EnumerableObjectCollection: TGUID = '{2D3468C1-36A7-43B6-AC24-D3F02FD9607A}';
  IID_IDesktopGadget: TGUID = '{C1646BC4-F298-4F91-A204-EB2DD1709D1A}';
  CLASS_DesktopGadget: TGUID = '{924CCC1B-6562-4C85-8657-D177925222B6}';
// Constants for enum CATEGORYINFO_FLAGS
type
  CATEGORYINFO_FLAGS = TOleEnum;
const
  CATINFO_NORMAL = $00000000;
  CATINFO_COLLAPSED = $00000001;
  CATINFO_HIDDEN = $00000002;
  CATINFO_EXPANDED = $00000004;
  CATINFO_NOHEADER = $00000008;
  CATINFO_NOTCOLLAPSIBLE = $00000010;
  CATINFO_NOHEADERCOUNT = $00000020;
  CATINFO_SUBSETTED = $00000040;

// Constants for enum CATSORT_FLAGS
type
  CATSORT_FLAGS = TOleEnum;
const
  CATSORT_DEFAULT = $00000000;
  CATSORT_NAME = $00000001;

// Constants for enum tagTYPEKIND
type
  tagTYPEKIND = TOleEnum;
const
  TKIND_ENUM = $00000000;
  TKIND_RECORD = $00000001;
  TKIND_MODULE = $00000002;
  TKIND_INTERFACE = $00000003;
  TKIND_DISPATCH = $00000004;
  TKIND_COCLASS = $00000005;
  TKIND_ALIAS = $00000006;
  TKIND_UNION = $00000007;
  TKIND_MAX = $00000008;

// Constants for enum tagDESCKIND
type
  tagDESCKIND = TOleEnum;
const
  DESCKIND_NONE = $00000000;
  DESCKIND_FUNCDESC = $00000001;
  DESCKIND_VARDESC = $00000002;
  DESCKIND_TYPECOMP = $00000003;
  DESCKIND_IMPLICITAPPOBJ = $00000004;
  DESCKIND_MAX = $00000005;

// Constants for enum tagFUNCKIND
type
  tagFUNCKIND = TOleEnum;
const
  FUNC_VIRTUAL = $00000000;
  FUNC_PUREVIRTUAL = $00000001;
  FUNC_NONVIRTUAL = $00000002;
  FUNC_STATIC = $00000003;
  FUNC_DISPATCH = $00000004;

// Constants for enum tagINVOKEKIND
type
  tagINVOKEKIND = TOleEnum;
const
  INVOKE_FUNC = $00000001;
  INVOKE_PROPERTYGET = $00000002;
  INVOKE_PROPERTYPUT = $00000004;
  INVOKE_PROPERTYPUTREF = $00000008;

// Constants for enum tagCALLCONV
type
  tagCALLCONV = TOleEnum;
const
  CC_FASTCALL = $00000000;
  CC_CDECL = $00000001;
  CC_MSCPASCAL = $00000002;
  CC_PASCAL = $00000002;
  CC_MACPASCAL = $00000003;
  CC_STDCALL = $00000004;
  CC_FPFASTCALL = $00000005;
  CC_SYSCALL = $00000006;
  CC_MPWCDECL = $00000007;
  CC_MPWPASCAL = $00000008;
  CC_MAX = $00000009;

// Constants for enum tagVARKIND
type
  tagVARKIND = TOleEnum;
const
  VAR_PERINSTANCE = $00000000;
  VAR_STATIC = $00000001;
  VAR_CONST = $00000002;
  VAR_DISPATCH = $00000003;

// Constants for enum tagSYSKIND
type
  tagSYSKIND = TOleEnum;
const
  SYS_WIN16 = $00000000;
  SYS_WIN32 = $00000001;
  SYS_MAC = $00000002;
  SYS_WIN64 = $00000003;

// Constants for enum TBPFLAG
type
  TBPFLAG = TOleEnum;
const
  TBPF_NOPROGRESS = $00000000;
  TBPF_INDETERMINATE = $00000001;
  TBPF_NORMAL = $00000002;
  TBPF_ERROR = $00000004;
  TBPF_PAUSED = $00000008;

// Constants for enum THUMBBUTTONMASK
type
  THUMBBUTTONMASK = TOleEnum;
const
  THB_BITMAP = $00000001;
  THB_ICON = $00000002;
  THB_TOOLTIP = $00000004;
  THB_FLAGS = $00000008;

// Constants for enum THUMBBUTTONFLAGS
type
  THUMBBUTTONFLAGS = TOleEnum;
const
  THBF_ENABLED = $00000000;
  THBF_DISABLED = $00000001;
  THBF_DISMISSONCLICK = $00000002;
  THBF_NOBACKGROUND = $00000004;
  THBF_HIDDEN = $00000008;
  THBF_NONINTERACTIVE = $00000010;

// Constants for enum STPFLAG
type
  STPFLAG = TOleEnum;
const
  STPF_NONE = $00000000;
  STPF_USEAPPTHUMBNAILALWAYS = $00000001;
  STPF_USEAPPTHUMBNAILWHENACTIVE = $00000002;
  STPF_USEAPPPEEKALWAYS = $00000004;
  STPF_USEAPPPEEKWHENACTIVE = $00000008;

// Constants for enum _SIGDN
type
  _SIGDN = TOleEnum;
const
  SIGDN_NORMALDISPLAY = $00000000;
  SIGDN_PARENTRELATIVEPARSING = $80018001;
  SIGDN_DESKTOPABSOLUTEPARSING = $80028000;
  SIGDN_PARENTRELATIVEEDITING = $80031001;
  SIGDN_DESKTOPABSOLUTEEDITING = $8004C000;
  SIGDN_FILESYSPATH = $80058000;
  SIGDN_URL = $80068000;
  SIGDN_PARENTRELATIVEFORADDRESSBAR = $8007C001;
  SIGDN_PARENTRELATIVE = $80080001;

// Constants for enum tagDOMNodeType
type
  tagDOMNodeType = TOleEnum;
const
  NODE_INVALID = $00000000;
  NODE_ELEMENT = $00000001;
  NODE_ATTRIBUTE = $00000002;
  NODE_TEXT = $00000003;
  NODE_CDATA_SECTION = $00000004;
  NODE_ENTITY_REFERENCE = $00000005;
  NODE_ENTITY = $00000006;
  NODE_PROCESSING_INSTRUCTION = $00000007;
  NODE_COMMENT = $00000008;
  NODE_DOCUMENT = $00000009;
  NODE_DOCUMENT_TYPE = $0000000A;
  NODE_DOCUMENT_FRAGMENT = $0000000B;
  NODE_NOTATION = $0000000C;

// Constants for enum EXPLORER_BROWSER_OPTIONS
type
  EXPLORER_BROWSER_OPTIONS = TOleEnum;
const
  EBO_NONE = $00000000;
  EBO_NAVIGATEONCE = $00000001;
  EBO_SHOWFRAMES = $00000002;
  EBO_ALWAYSNAVIGATE = $00000004;
  EBO_NOTRAVELLOG = $00000008;
  EBO_NOWRAPPERWINDOW = $00000010;
  EBO_HTMLSHAREPOINTVIEW = $00000020;

// Constants for enum EXPLORER_BROWSER_FILL_FLAGS
type
  EXPLORER_BROWSER_FILL_FLAGS = TOleEnum;
const
  EBF_NONE = $00000000;
  EBF_SELECTFROMDATAOBJECT = $00000100;
  EBF_NODROPTARGET = $00000200;

// Constants for enum ATTACHMENT_PROMPT
type
  ATTACHMENT_PROMPT = TOleEnum;
const
  ATTACHMENT_PROMPT_NONE = $00000000;
  ATTACHMENT_PROMPT_SAVE = $00000001;
  ATTACHMENT_PROMPT_EXEC = $00000002;
  ATTACHMENT_PROMPT_EXEC_OR_SAVE = $00000003;

// Constants for enum ATTACHMENT_ACTION
type
  ATTACHMENT_ACTION = TOleEnum;
const
  ATTACHMENT_ACTION_CANCEL = $00000000;
  ATTACHMENT_ACTION_SAVE = $00000001;
  ATTACHMENT_ACTION_EXEC = $00000002;

// Constants for enum GETPROPERTYSTOREFLAGS
type
  GETPROPERTYSTOREFLAGS = TOleEnum;
const
  GPS_DEFAULT = $00000000;
  GPS_HANDLERPROPERTIESONLY = $00000001;
  GPS_READWRITE = $00000002;
  GPS_TEMPORARY = $00000004;
  GPS_FASTPROPERTIESONLY = $00000008;
  GPS_OPENSLOWITEM = $00000010;
  GPS_DELAYCREATION = $00000020;
  GPS_BESTEFFORT = $00000040;
  GPS_NO_OPLOCK = $00000080;
  GPS_MASK_VALID = $000000FF;

// Constants for enum _SPACTION
type
  _SPACTION = TOleEnum;
const
  SPACTION_NONE = $00000000;
  SPACTION_MOVING = $00000001;
  SPACTION_COPYING = $00000002;
  SPACTION_RECYCLING = $00000003;
  SPACTION_APPLYINGATTRIBS = $00000004;
  SPACTION_DOWNLOADING = $00000005;
  SPACTION_SEARCHING_INTERNET = $00000006;
  SPACTION_CALCULATING = $00000007;
  SPACTION_UPLOADING = $00000008;
  SPACTION_SEARCHING_FILES = $00000009;
  SPACTION_DELETING = $0000000A;
  SPACTION_RENAMING = $0000000B;
  SPACTION_FORMATTING = $0000000C;
  SPACTION_COPY_MOVING = $0000000D;

// Constants for enum PDOPSTATUS
type
  PDOPSTATUS = TOleEnum;
const
  PDOPS_RUNNING = $00000001;
  PDOPS_PAUSED = $00000002;
  PDOPS_CANCELLED = $00000003;
  PDOPS_STOPPED = $00000004;
  PDOPS_ERRORS = $00000005;

// Constants for enum FDE_SHAREVIOLATION_RESPONSE
type
  FDE_SHAREVIOLATION_RESPONSE = TOleEnum;
const
  FDESVR_DEFAULT = $00000000;
  FDESVR_ACCEPT = $00000001;
  FDESVR_REFUSE = $00000002;

// Constants for enum FDE_OVERWRITE_RESPONSE
type
  FDE_OVERWRITE_RESPONSE = TOleEnum;
const
  FDEOR_DEFAULT = $00000000;
  FDEOR_ACCEPT = $00000001;
  FDEOR_REFUSE = $00000002;

// Constants for enum FDAP
type
  FDAP = TOleEnum;
const
  FDAP_BOTTOM = $00000000;
  FDAP_TOP = $00000001;

// Constants for enum SIATTRIBFLAGS
type
  SIATTRIBFLAGS = TOleEnum;
const
  SIATTRIBFLAGS_AND = $00000001;
  SIATTRIBFLAGS_OR = $00000002;
  SIATTRIBFLAGS_APPCOMPAT = $00000003;
  SIATTRIBFLAGS_MASK = $00000003;
  SIATTRIBFLAGS_ALLITEMS = $00004000;

// Constants for enum KF_CATEGORY
type
  KF_CATEGORY = TOleEnum;
const
  KF_CATEGORY_VIRTUAL = $00000001;
  KF_CATEGORY_FIXED = $00000002;
  KF_CATEGORY_COMMON = $00000003;
  KF_CATEGORY_PERUSER = $00000004;

// Constants for enum FFFP_MODE
type
  FFFP_MODE = TOleEnum;
const
  FFFP_EXACTMATCH = $00000000;
  FFFP_NEARESTPARENTMATCH = $00000001;

// Constants for enum DEF_SHARE_ID
type
  DEF_SHARE_ID = TOleEnum;
const
  DEFSHAREID_USERS = $00000001;
  DEFSHAREID_PUBLIC = $00000002;

// Constants for enum SHARE_ROLE
type
  SHARE_ROLE = TOleEnum;
const
  SHARE_ROLE_INVALID = $FFFFFFFF;
  SHARE_ROLE_READER = $00000000;
  SHARE_ROLE_CONTRIBUTOR = $00000001;
  SHARE_ROLE_CO_OWNER = $00000002;
  SHARE_ROLE_OWNER = $00000003;
  SHARE_ROLE_CUSTOM = $00000004;
  SHARE_ROLE_MIXED = $00000005;

// Constants for enum NSTCGNI
type
  NSTCGNI = TOleEnum;
const
  NSTCGNI_NEXT = $00000000;
  NSTCGNI_NEXTVISIBLE = $00000001;
  NSTCGNI_PREV = $00000002;
  NSTCGNI_PREVVISIBLE = $00000003;
  NSTCGNI_PARENT = $00000004;
  NSTCGNI_CHILD = $00000005;
  NSTCGNI_FIRSTVISIBLE = $00000006;
  NSTCGNI_LASTVISIBLE = $00000007;

// Constants for enum NSTCSTYLE2
type
  NSTCSTYLE2 = TOleEnum;
const
  NSTCS2_DEFAULT = $00000000;
  NSTCS2_INTERRUPTNOTIFICATIONS = $00000001;
  NSTCS2_SHOWNULLSPACEMENU = $00000002;
  NSTCS2_DISPLAYPADDING = $00000004;
  NSTCS2_DISPLAYPINNEDONLY = $00000008;
  NTSCS2_NOSINGLETONAUTOEXPAND = $00000010;
  NTSCS2_NEVERINSERTNONENUMERATED = $00000020;

// Constants for enum ASSOCIATIONTYPE
type
  ASSOCIATIONTYPE = TOleEnum;
const
  AT_FILEEXTENSION = $00000000;
  AT_URLPROTOCOL = $00000001;
  AT_STARTMENUCLIENT = $00000002;
  AT_MIMETYPE = $00000003;

// Constants for enum ASSOCIATIONLEVEL
type
  ASSOCIATIONLEVEL = TOleEnum;
const
  AL_MACHINE = $00000000;
  AL_EFFECTIVE = $00000001;
  AL_USER = $00000002;

// Constants for enum FOLDERLOGICALVIEWMODE
type
  FOLDERLOGICALVIEWMODE = TOleEnum;
const
  FLVM_UNSPECIFIED = $FFFFFFFF;
  FLVM_FIRST = $00000001;
  FLVM_DETAILS = $00000001;
  FLVM_TILES = $00000002;
  FLVM_ICONS = $00000003;
  FLVM_LIST = $00000004;
  FLVM_CONTENT = $00000005;
  FLVM_LAST = $00000005;

// Constants for enum tagCONDITION_TYPE
type
  tagCONDITION_TYPE = TOleEnum;
const
  CT_AND_CONDITION = $00000000;
  CT_OR_CONDITION = $00000001;
  CT_NOT_CONDITION = $00000002;
  CT_LEAF_CONDITION = $00000003;

// Constants for enum tagCONDITION_OPERATION
type
  tagCONDITION_OPERATION = TOleEnum;
const
  COP_IMPLICIT = $00000000;
  COP_EQUAL = $00000001;
  COP_NOTEQUAL = $00000002;
  COP_LESSTHAN = $00000003;
  COP_GREATERTHAN = $00000004;
  COP_LESSTHANOREQUAL = $00000005;
  COP_GREATERTHANOREQUAL = $00000006;
  COP_VALUE_STARTSWITH = $00000007;
  COP_VALUE_ENDSWITH = $00000008;
  COP_VALUE_CONTAINS = $00000009;
  COP_VALUE_NOTCONTAINS = $0000000A;
  COP_DOSWILDCARDS = $0000000B;
  COP_WORD_EQUAL = $0000000C;
  COP_WORD_STARTSWITH = $0000000D;
  COP_APPLICATION_SPECIFIC = $0000000E;

// Constants for enum CPVIEW
type
  CPVIEW = TOleEnum;
const
  CPVIEW_CLASSIC = $00000000;
  CPVIEW_ALLITEMS = $00000000;
  CPVIEW_CATEGORY = $00000001;
  CPVIEW_HOME = $00000001;

// Constants for enum KNOWNDESTCATEGORY
type
  KNOWNDESTCATEGORY = TOleEnum;
const
  KDC_FREQUENT = $00000001;
  KDC_RECENT = $00000002;

// Constants for enum APPDOCLISTTYPE
type
  APPDOCLISTTYPE = TOleEnum;
const
  ADLT_RECENT = $00000000;
  ADLT_FREQUENT = $00000001;

// Constants for enum HOMEGROUPSHARINGCHOICES
type
  HOMEGROUPSHARINGCHOICES = TOleEnum;
const
  HGSC_NONE = $00000000;
  HGSC_MUSICLIBRARY = $00000001;
  HGSC_PICTURESLIBRARY = $00000002;
  HGSC_VIDEOSLIBRARY = $00000004;
  HGSC_DOCUMENTSLIBRARY = $00000008;
  HGSC_PRINTERS = $00000010;

// Constants for enum LIBRARYFOLDERFILTER
type
  LIBRARYFOLDERFILTER = TOleEnum;
const
  LFF_FORCEFILESYSTEM = $00000001;
  LFF_STORAGEITEMS = $00000002;
  LFF_ALLITEMS = $00000003;

// Constants for enum DEFAULTSAVEFOLDERTYPE
type
  DEFAULTSAVEFOLDERTYPE = TOleEnum;
const
  DSFT_DETECT = $00000001;
  DSFT_PRIVATE = $00000002;
  DSFT_PUBLIC = $00000003;

// Constants for enum LIBRARYOPTIONFLAGS
type
  LIBRARYOPTIONFLAGS = TOleEnum;
const
  LOF_DEFAULT = $00000000;
  LOF_PINNEDTONAVPANE = $00000001;
  LOF_MASK_ALL = $00000001;

// Constants for enum LIBRARYSAVEFLAGS
type
  LIBRARYSAVEFLAGS = TOleEnum;
const
  LSF_FAILIFTHERE = $00000000;
  LSF_OVERRIDEEXISTING = $00000001;
  LSF_MAKEUNIQUENAME = $00000002;

type
  IShellFolder = interface;
  IShellFolder2 = interface;
  IBindCtx = interface;
  IRunningObjectTable = interface;
  IPersist = interface;
  IPersistStream = interface;
  IMoniker = interface;
  ISequentialStream = interface;
  IStream = interface;
  IEnumMoniker = interface;
  IEnumString = interface;
  IEnumIDList = interface;
  IEnumExtraSearch = interface;
  IShellLinkW = interface;
  IQueryCancelAutoPlay = interface;
  ICategorizer = interface;
  IPersistFile = interface;
  IPropertyUI = interface;
  IStorage = interface;
  IEnumSTATSTG = interface;
  IRecordInfo = interface;
  ITypeInfo = interface;
  ITypeComp = interface;
  ITypeLib = interface;
  IUserNotification = interface;
  IQueryContinue = interface;
  ICDBurn = interface;
  ITaskbarList = interface;
  ITaskbarList2 = interface;
  ITaskbarList3 = interface;
  ITaskbarList4 = interface;
  IStartMenuPinnedList = interface;
  IShellItem = interface;
  IWizardExtension = interface;
  IWebWizardExtension = interface;
  IDropTarget = interface;
  IDataObject = interface;
  IEnumFORMATETC = interface;
  IAdviseSink = interface;
  IEnumSTATDATA = interface;
  IPublishingWizard = interface;
  IXMLDOMNode = interface;
  IXMLDOMNodeDisp = dispinterface;
  IXMLDOMDocument = interface;
  IXMLDOMDocumentDisp = dispinterface;
  IXMLDOMNodeList = interface;
  IXMLDOMNodeListDisp = dispinterface;
  IXMLDOMNamedNodeMap = interface;
  IXMLDOMNamedNodeMapDisp = dispinterface;
  IXMLDOMDocumentType = interface;
  IXMLDOMDocumentTypeDisp = dispinterface;
  IXMLDOMImplementation = interface;
  IXMLDOMImplementationDisp = dispinterface;
  IXMLDOMElement = interface;
  IXMLDOMElementDisp = dispinterface;
  IXMLDOMAttribute = interface;
  IXMLDOMAttributeDisp = dispinterface;
  IXMLDOMDocumentFragment = interface;
  IXMLDOMDocumentFragmentDisp = dispinterface;
  IXMLDOMCharacterData = interface;
  IXMLDOMCharacterDataDisp = dispinterface;
  IXMLDOMText = interface;
  IXMLDOMTextDisp = dispinterface;
  IXMLDOMComment = interface;
  IXMLDOMCommentDisp = dispinterface;
  IXMLDOMCDATASection = interface;
  IXMLDOMCDATASectionDisp = dispinterface;
  IXMLDOMProcessingInstruction = interface;
  IXMLDOMProcessingInstructionDisp = dispinterface;
  IXMLDOMEntityReference = interface;
  IXMLDOMEntityReferenceDisp = dispinterface;
  IXMLDOMParseError = interface;
  IXMLDOMParseErrorDisp = dispinterface;
  IFolderViewHost = interface;
  IExplorerBrowser = interface;
  IExplorerBrowserEvents = interface;
  IOleWindow = interface;
  IShellView = interface;
  IShellBrowser = interface;
  IImageRecompress = interface;
  IBandSite = interface;
  IDockingWindow = interface;
  IDeskBand = interface;
  ITrayDeskBand = interface;
  IAttachmentExecute = interface;
  IShellExtInit = interface;
  IShellItem2 = interface;
  INamespaceWalk = interface;
  INamespaceWalkCB = interface;
  IFileOperation = interface;
  IFileOperationProgressSink = interface;
  IOperationsProgressDialog = interface;
  IPropertyChangeArray = interface;
  IObjectWithPropertyKey = interface;
  IPropertyChange = interface;
  IModalWindow = interface;
  IFileDialog = interface;
  IFileOpenDialog = interface;
  IFileDialogEvents = interface;
  IShellItemFilter = interface;
  IShellItemArray = interface;
  IEnumShellItems = interface;
  IFileSaveDialog = interface;
  IPropertyStore = interface;
  IPropertyDescriptionList = interface;
  IKnownFolderManager = interface;
  IKnownFolder = interface;
  ISharingConfigurationManager = interface;
  IPreviousVersionsInfo = interface;
  INameSpaceTreeControl = interface;
  INameSpaceTreeControl2 = interface;
  IApplicationAssociationRegistration = interface;
  IApplicationAssociationRegistrationUI = interface;
  ISearchFolderItemFactory = interface;
  ICondition = interface;
  IRichChunk = interface;
  IOpenControlPanel = interface;
  ICustomDestinationList = interface;
  IObjectArray = interface;
  IApplicationDestinations = interface;
  IApplicationDocumentLists = interface;
  IHomeGroup = interface;
  IShellLibrary = interface;
  IEnumObjects = interface;
  IDesktopGadget = interface;
  ShellDesktop = IShellFolder2;
  ShellFSFolder = IShellFolder2;
  NetworkPlaces = IShellFolder2;
  ShellLink = IShellLinkW;
  QueryCancelAutoPlay = IQueryCancelAutoPlay;
  DriveSizeCategorizer = ICategorizer;
  DriveTypeCategorizer = ICategorizer;
  FreeSpaceCategorizer = ICategorizer;
  TimeCategorizer = ICategorizer;
  SizeCategorizer = ICategorizer;
  AlphabeticalCategorizer = ICategorizer;
  MergedCategorizer = ICategorizer;
  ImageProperties = IPersistFile;
  PropertiesUI = IPropertyUI;
  UserNotification = IUserNotification;
  CDBurn = ICDBurn;
  TaskbarList = ITaskbarList4;
  StartMenuPin = IStartMenuPinnedList;
  WebWizardHost = IWebWizardExtension;
  PublishDropTarget = IDropTarget;
  PublishingWizard = IPublishingWizard;
  InternetPrintOrdering = IDropTarget;
  FolderViewHost = IFolderViewHost;
  ExplorerBrowser = IExplorerBrowser;
  ImageRecompress = IImageRecompress;
  TrayBandSiteService = IBandSite;
  TrayDeskBand = ITrayDeskBand;
  AttachmentServices = IAttachmentExecute;
  DocPropShellExtension = IShellExtInit;
  ShellItem = IShellItem2;
  NamespaceWalker = INamespaceWalk;
  FileOperation = IFileOperation;
  FileOpenDialog = IFileOpenDialog;
  FileSaveDialog = IFileSaveDialog;
  KnownFolderManager = IKnownFolderManager;
  FSCopyHandler = IUnknown;
  SharingConfigurationManager = ISharingConfigurationManager;
  PreviousVersions = IPreviousVersionsInfo;
  NetworkConnections = IShellFolder2;
  NamespaceTreeControl = INameSpaceTreeControl2;
  IENamespaceTreeControl = IUnknown;
  ScheduledTasks = IShellFolder2;
  ApplicationAssociationRegistration = IApplicationAssociationRegistration;
  ApplicationAssociationRegistrationUI = IApplicationAssociationRegistrationUI;
  SearchFolderItemFactory = ISearchFolderItemFactory;
  OpenControlPanel = IOpenControlPanel;
  MailRecipient = IDropTarget;
  NetworkExplorerFolder = IShellFolder2;
  DestinationList = ICustomDestinationList;
  ApplicationDestinations = IApplicationDestinations;
  ApplicationDocumentLists = IApplicationDocumentLists;
  HomeGroup = IHomeGroup;
  ShellLibrary = IShellLibrary;
  AppStartupLink = IShellLinkW;
  EnumerableObjectCollection = IEnumObjects;
  DesktopGadget = IDesktopGadget;

  wireHWND = ^_RemotableHandle; 
  wirePIDL = ^_BYTE_BLOB; 
  wirePSAFEARRAY = ^PUserType6; 
  wireSNB = ^tagRemSNB; 
  PUserType7 = ^_FLAGGED_WORD_BLOB; {*}
  PUserType8 = ^_wireVARIANT; {*}
  PUserType15 = ^_wireBRECORD; {*}
  PUserType6 = ^_wireSAFEARRAY; {*}
  PPUserType2 = ^PUserType6; {*}
  PUserType12 = ^tagTYPEDESC; {*}
  PUserType13 = ^tagARRAYDESC; {*}
  PUserType5 = ^tag_inner_PROPVARIANT; {*}
  wireHICON = ^_RemotableHandle; 
  wireCLIPFORMAT = ^_userCLIPFORMAT; 
  wireSTGMEDIUM = ^_userSTGMEDIUM; 
  wireFLAG_STGMEDIUM = ^_userFLAG_STGMEDIUM; 
  wireASYNC_STGMEDIUM = ^_userSTGMEDIUM; 
  wireHMENU = ^_RemotableHandle; 
  wireHGLOBAL = ^_userHGLOBAL; 
  PUserType1 = ^_tagpropertykey; {*}
  PUserType2 = ^TGUID; {*}
  PPUserType1 = ^wirePIDL; {*}
  PUserType3 = ^tagBIND_OPTS2; {*}
  PUserType4 = ^_FILETIME; {*}
  PByte1 = ^Byte; {*}
  POleVariant1 = ^OleVariant; {*}
  PUserType9 = ^tagTYPEATTR; {*}
  PUserType10 = ^tagFUNCDESC; {*}
  PUserType11 = ^tagVARDESC; {*}
  PUserType14 = ^tagTLIBATTR; {*}
  PUserType16 = ^THUMBBUTTON; {*}
  PUserType17 = ^tagRECT; {*}
  PUserType18 = ^tagFORMATETC; {*}
  PPUserType3 = ^wireFLAG_STGMEDIUM; {*}
  PPUserType4 = ^wireASYNC_STGMEDIUM; {*}
  PPUserType5 = ^IXMLDOMDocumentType; {*}
  PPUserType6 = ^IXMLDOMImplementation; {*}
  PPUserType7 = ^IXMLDOMElement; {*}
  PPUserType8 = ^IXMLDOMDocumentFragment; {*}
  PPUserType9 = ^IXMLDOMText; {*}
  PPUserType10 = ^IXMLDOMComment; {*}
  PPUserType11 = ^IXMLDOMCDATASection; {*}
  PPUserType12 = ^IXMLDOMProcessingInstruction; {*}
  PPUserType13 = ^IXMLDOMAttribute; {*}
  PPUserType14 = ^IXMLDOMEntityReference; {*}
  PPUserType15 = ^IXMLDOMParseError; {*}
  PPUserType16 = ^IXMLDOMNodeList; {*}
  PPUserType17 = ^IXMLDOMNamedNodeMap; {*}
  PPUserType18 = ^IXMLDOMDocument; {*}
  PUserType19 = ^FOLDERSETTINGS; {*}
  PUserType20 = ^tagMSG; {*}
  PUserType21 = ^tagBANDSITEINFO; {*}
  PUserType22 = ^_COMDLG_FILTERSPEC; {*}
  PUserType23 = ^KNOWNFOLDER_DEFINITION; {*}
  PUserType24 = ^tagPOINT; {*}
  PUserType25 = ^SORTCOLUMN; {*}


  __MIDL_IWinTypes_0009 = record
    case Integer of
      0: (hInproc: Integer);
      1: (hRemote: Integer);
  end;

  _RemotableHandle = record
    fContext: Integer;
    u: __MIDL_IWinTypes_0009;
  end;

  _COAUTHIDENTITY = record
    User: ^Word;
    UserLength: LongWord;
    Domain: ^Word;
    DomainLength: LongWord;
    Password: ^Word;
    PasswordLength: LongWord;
    Flags: LongWord;
  end;

  _COAUTHINFO = record
    dwAuthnSvc: LongWord;
    dwAuthzSvc: LongWord;
    pwszServerPrincName: PWideChar;
    dwAuthnLevel: LongWord;
    dwImpersonationLevel: LongWord;
    pAuthIdentityData: ^_COAUTHIDENTITY;
    dwCapabilities: LongWord;
  end;

  _COSERVERINFO = record
    dwReserved1: LongWord;
    pwszName: PWideChar;
    pAuthInfo: ^_COAUTHINFO;
    dwReserved2: LongWord;
  end;

  tagBIND_OPTS2 = record
    cbStruct: LongWord;
    grfFlags: LongWord;
    grfMode: LongWord;
    dwTickCountDeadline: LongWord;
    dwTrackFlags: LongWord;
    dwClassContext: LongWord;
    locale: LongWord;
    pServerInfo: ^_COSERVERINFO;
  end;

{$ALIGN 8}
  _LARGE_INTEGER = record
    QuadPart: Int64;
  end;

{$ALIGN 8}
  _ULARGE_INTEGER = record
    QuadPart: Largeuint;
  end;

  _FILETIME = record
    dwLowDateTime: LongWord;
    dwHighDateTime: LongWord;
  end;

{$ALIGN 8}
  tagSTATSTG = record
    pwcsName: PWideChar;
    type_: LongWord;
    cbSize: _ULARGE_INTEGER;
    mtime: _FILETIME;
    ctime: _FILETIME;
    atime: _FILETIME;
    grfMode: LongWord;
    grfLocksSupported: LongWord;
    clsid: TGUID;
    grfStateBits: LongWord;
    reserved: LongWord;
  end;


  _BYTE_BLOB = record
    clSize: LongWord;
    abData: ^Byte;
  end;

  LONG_PTR = Integer; 

  __MIDL___MIDL_itf_ShObjIdl_0001_0142_0001 = record
    case Integer of
      0: (pOleStr: PWideChar);
      1: (uOffset: SYSUINT);
      2: (cStr: array[0..259] of Shortint);
  end;

  _STRRET = record
    uType: SYSUINT;
    DUMMYUNIONNAME: __MIDL___MIDL_itf_ShObjIdl_0001_0142_0001;
  end;

  EXTRASEARCH = record
    guidSearch: TGUID;
    wszFriendlyName: array[0..79] of Word;
    wszUrl: array[0..2083] of Word;
  end;

  _tagpropertykey = record
    fmtid: TGUID;
    pid: LongWord;
  end;

  _SHELLDETAILS = record
    fmt: SYSINT;
    cxChar: SYSINT;
    str: _STRRET;
  end;

  _WIN32_FIND_DATAW = record
    dwFileAttributes: LongWord;
    ftCreationTime: _FILETIME;
    ftLastAccessTime: _FILETIME;
    ftLastWriteTime: _FILETIME;
    nFileSizeHigh: LongWord;
    nFileSizeLow: LongWord;
    dwReserved0: LongWord;
    dwReserved1: LongWord;
    cFileName: array[0..259] of Word;
    cAlternateFileName: array[0..13] of Word;
  end;

  CATEGORY_INFO = record
    cif: CATEGORYINFO_FLAGS;
    wszName: array[0..259] of Word;
  end;

  tagCLIPDATA = record
    cbSize: LongWord;
    ulClipFmt: Integer;
    pClipData: ^Byte;
  end;

  tagBSTRBLOB = record
    cbSize: LongWord;
    pData: ^Byte;
  end;

  tagBLOB = record
    cbSize: LongWord;
    pBlobData: ^Byte;
  end;

  tagVersionedStream = record
    guidVersion: TGUID;
    pStream: IStream;
  end;


  tagRemSNB = record
    ulCntStr: LongWord;
    ulCntChar: LongWord;
    rgString: ^Word;
  end;

  tagCAC = record
    cElems: LongWord;
    pElems: ^Shortint;
  end;

  tagCAUB = record
    cElems: LongWord;
    pElems: ^Byte;
  end;


  _wireSAFEARR_BSTR = record
    Size: LongWord;
    aBstr: ^PUserType7;
  end;

  _wireSAFEARR_UNKNOWN = record
    Size: LongWord;
    apUnknown: ^IUnknown;
  end;

  _wireSAFEARR_DISPATCH = record
    Size: LongWord;
    apDispatch: ^IDispatch;
  end;

  _FLAGGED_WORD_BLOB = record
    fFlags: LongWord;
    clSize: LongWord;
    asData: ^Word;
  end;


  _wireSAFEARR_VARIANT = record
    Size: LongWord;
    aVariant: ^PUserType8;
  end;


  _wireBRECORD = record
    fFlags: LongWord;
    clSize: LongWord;
    pRecInfo: IRecordInfo;
    pRecord: ^Byte;
  end;


  __MIDL_IOleAutomationTypes_0005 = record
    case Integer of
      0: (lptdesc: PUserType12);
      1: (lpadesc: PUserType13);
      2: (hreftype: LongWord);
  end;

  tagTYPEDESC = record
    DUMMYUNIONNAME: __MIDL_IOleAutomationTypes_0005;
    vt: Word;
  end;

  tagSAFEARRAYBOUND = record
    cElements: LongWord;
    lLbound: Integer;
  end;

  ULONG_PTR = LongWord; 

  tagIDLDESC = record
    dwReserved: ULONG_PTR;
    wIDLFlags: Word;
  end;

  DWORD = LongWord; 

{$ALIGN 8}
  tagPARAMDESCEX = record
    cBytes: LongWord;
    varDefaultValue: OleVariant;
  end;

  tagPARAMDESC = record
    pparamdescex: ^tagPARAMDESCEX;
    wParamFlags: Word;
  end;

  tagELEMDESC = record
    tdesc: tagTYPEDESC;
    paramdesc: tagPARAMDESC;
  end;

  tagFUNCDESC = record
    memid: Integer;
    lprgscode: ^SCODE;
    lprgelemdescParam: ^tagELEMDESC;
    funckind: tagFUNCKIND;
    invkind: tagINVOKEKIND;
    callconv: tagCALLCONV;
    cParams: Smallint;
    cParamsOpt: Smallint;
    oVft: Smallint;
    cScodes: Smallint;
    elemdescFunc: tagELEMDESC;
    wFuncFlags: Word;
  end;

  __MIDL_IOleAutomationTypes_0006 = record
    case Integer of
      0: (oInst: LongWord);
      1: (lpvarValue: ^OleVariant);
  end;

  tagVARDESC = record
    memid: Integer;
    lpstrSchema: PWideChar;
    DUMMYUNIONNAME: __MIDL_IOleAutomationTypes_0006;
    elemdescVar: tagELEMDESC;
    wVarFlags: Word;
    varkind: tagVARKIND;
  end;

  tagTLIBATTR = record
    guid: TGUID;
    lcid: LongWord;
    syskind: tagSYSKIND;
    wMajorVerNum: Word;
    wMinorVerNum: Word;
    wLibFlags: Word;
  end;

  _wireSAFEARR_BRECORD = record
    Size: LongWord;
    aRecord: ^PUserType15;
  end;

  _wireSAFEARR_HAVEIID = record
    Size: LongWord;
    apUnknown: ^IUnknown;
    iid: TGUID;
  end;

  _BYTE_SIZEDARR = record
    clSize: LongWord;
    pData: ^Byte;
  end;

  _SHORT_SIZEDARR = record
    clSize: LongWord;
    pData: ^Word;
  end;

  _LONG_SIZEDARR = record
    clSize: LongWord;
    pData: ^LongWord;
  end;

  _HYPER_SIZEDARR = record
    clSize: LongWord;
    pData: ^Int64;
  end;

  tagCAI = record
    cElems: LongWord;
    pElems: ^Smallint;
  end;

  tagCAUI = record
    cElems: LongWord;
    pElems: ^Word;
  end;

  tagCAL = record
    cElems: LongWord;
    pElems: ^Integer;
  end;

  tagCAUL = record
    cElems: LongWord;
    pElems: ^LongWord;
  end;

  tagCAH = record
    cElems: LongWord;
    pElems: ^_LARGE_INTEGER;
  end;

  tagCAUH = record
    cElems: LongWord;
    pElems: ^_ULARGE_INTEGER;
  end;

  tagCAFLT = record
    cElems: LongWord;
    pElems: ^Single;
  end;

  tagCADBL = record
    cElems: LongWord;
    pElems: ^Double;
  end;

  tagCABOOL = record
    cElems: LongWord;
    pElems: ^WordBool;
  end;

  tagCASCODE = record
    cElems: LongWord;
    pElems: ^SCODE;
  end;

  tagCACY = record
    cElems: LongWord;
    pElems: ^Currency;
  end;

  tagCADATE = record
    cElems: LongWord;
    pElems: ^TDateTime;
  end;

  tagCAFILETIME = record
    cElems: LongWord;
    pElems: ^_FILETIME;
  end;

  tagCACLSID = record
    cElems: LongWord;
    pElems: ^TGUID;
  end;

  tagCACLIPDATA = record
    cElems: LongWord;
    pElems: ^tagCLIPDATA;
  end;

  tagCABSTR = record
    cElems: LongWord;
    pElems: ^WideString;
  end;

  tagCABSTRBLOB = record
    cElems: LongWord;
    pElems: ^tagBSTRBLOB;
  end;

  tagCALPSTR = record
    cElems: LongWord;
    pElems: ^PChar;
  end;

  tagCALPWSTR = record
    cElems: LongWord;
    pElems: ^PWideChar;
  end;


  tagCAPROPVARIANT = record
    cElems: LongWord;
    pElems: PUserType5;
  end;

{$ALIGN 8}
  __MIDL___MIDL_itf_ShObjIdl_0001_0149_0001 = record
    case Integer of
      0: (cVal: Shortint);
      1: (bVal: Byte);
      2: (iVal: Smallint);
      3: (uiVal: Word);
      4: (lVal: Integer);
      5: (ulVal: LongWord);
      6: (intVal: SYSINT);
      7: (uintVal: SYSUINT);
      8: (hVal: _LARGE_INTEGER);
      9: (uhVal: _ULARGE_INTEGER);
      10: (fltVal: Single);
      11: (dblVal: Double);
      12: (boolVal: WordBool);
      13: (bool: WordBool);
      14: (scode: SCODE);
      15: (cyVal: Currency);
      16: (date: TDateTime);
      17: (filetime: _FILETIME);
      18: (puuid: ^TGUID);
      19: (pClipData: ^tagCLIPDATA);
      20: (bstrVal: {!!WideString}Pointer);
      21: (bstrblobVal: tagBSTRBLOB);
      22: (blob: tagBLOB);
      23: (pszVal: PChar);
      24: (pwszVal: PWideChar);
      25: (punkVal: {!!IUnknown}Pointer);
      26: (pdispVal: {!!IDispatch}Pointer);
      27: (pStream: {!!IStream}Pointer);
      28: (pStorage: {!!IStorage}Pointer);
      29: (pVersionedStream: ^tagVersionedStream);
      30: (parray: wirePSAFEARRAY);
      31: (cac: tagCAC);
      32: (caub: tagCAUB);
      33: (cai: tagCAI);
      34: (caui: tagCAUI);
      35: (cal: tagCAL);
      36: (caul: tagCAUL);
      37: (cah: tagCAH);
      38: (cauh: tagCAUH);
      39: (caflt: tagCAFLT);
      40: (cadbl: tagCADBL);
      41: (cabool: tagCABOOL);
      42: (cascode: tagCASCODE);
      43: (cacy: tagCACY);
      44: (cadate: tagCADATE);
      45: (cafiletime: tagCAFILETIME);
      46: (cauuid: tagCACLSID);
      47: (caclipdata: tagCACLIPDATA);
      48: (cabstr: tagCABSTR);
      49: (cabstrblob: tagCABSTRBLOB);
      50: (calpstr: tagCALPSTR);
      51: (calpwstr: tagCALPWSTR);
      52: (capropvar: tagCAPROPVARIANT);
      53: (pcVal: ^Shortint);
      54: (pbVal: ^Byte);
      55: (piVal: ^Smallint);
      56: (puiVal: ^Word);
      57: (plVal: ^Integer);
      58: (pulVal: ^LongWord);
      59: (pintVal: ^SYSINT);
      60: (puintVal: ^SYSUINT);
      61: (pfltVal: ^Single);
      62: (pdblVal: ^Double);
      63: (pboolVal: ^WordBool);
      64: (pdecVal: ^TDecimal);
      65: (pscode: ^SCODE);
      66: (pcyVal: ^Currency);
      67: (pdate: ^TDateTime);
      68: (pbstrVal: ^WideString);
      69: (ppunkVal: {!!^IUnknown}Pointer);
      70: (ppdispVal: {!!^IDispatch}Pointer);
      71: (pparray: ^wirePSAFEARRAY);
      72: (pvarVal: PUserType5);
  end;

{$ALIGN 4}

  THUMBBUTTON = record
    dwMask: THUMBBUTTONMASK;
    iid: SYSUINT;
    iBitmap: SYSUINT;
    hIcon: wireHICON;
    szTip: array[0..259] of Word;
    dwFlags: THUMBBUTTONFLAGS;
  end;

  tagRECT = record
    left: Integer;
    top: Integer;
    right: Integer;
    bottom: Integer;
  end;


  tagDVTARGETDEVICE = record
    tdSize: LongWord;
    tdDriverNameOffset: Word;
    tdDeviceNameOffset: Word;
    tdPortNameOffset: Word;
    tdExtDevmodeOffset: Word;
    tdData: ^Byte;
  end;

  __MIDL_IWinTypes_0001 = record
    case Integer of
      0: (dwValue: LongWord);
      1: (pwszName: PWideChar);
  end;

  _userCLIPFORMAT = record
    fContext: Integer;
    u: __MIDL_IWinTypes_0001;
  end;

  tagFORMATETC = record
    cfFormat: wireCLIPFORMAT;
    ptd: ^tagDVTARGETDEVICE;
    dwAspect: LongWord;
    lindex: Integer;
    tymed: LongWord;
  end;


{$ALIGN 8}
  __MIDL_IWinTypes_0004 = record
    case Integer of
      0: (hInproc: Integer);
      1: (hRemote: ^_BYTE_BLOB);
      2: (hInproc64: Int64);
  end;

{$ALIGN 4}
{$ALIGN 8}
  _userHMETAFILE = record
    fContext: Integer;
    u: __MIDL_IWinTypes_0004;
  end;

  _remoteMETAFILEPICT = record
    mm: Integer;
    xExt: Integer;
    yExt: Integer;
    hMF: ^_userHMETAFILE;
  end;

{$ALIGN 8}
  __MIDL_IWinTypes_0005 = record
    case Integer of
      0: (hInproc: Integer);
      1: (hRemote: ^_remoteMETAFILEPICT);
      2: (hInproc64: Int64);
  end;

{$ALIGN 4}
{$ALIGN 8}
  _userHMETAFILEPICT = record
    fContext: Integer;
    u: __MIDL_IWinTypes_0005;
  end;

{$ALIGN 8}
  __MIDL_IWinTypes_0006 = record
    case Integer of
      0: (hInproc: Integer);
      1: (hRemote: ^_BYTE_BLOB);
      2: (hInproc64: Int64);
  end;

{$ALIGN 4}
{$ALIGN 8}
  _userHENHMETAFILE = record
    fContext: Integer;
    u: __MIDL_IWinTypes_0006;
  end;

  _userBITMAP = record
    bmType: Integer;
    bmWidth: Integer;
    bmHeight: Integer;
    bmWidthBytes: Integer;
    bmPlanes: Word;
    bmBitsPixel: Word;
    cbSize: LongWord;
    pBuffer: ^Byte;
  end;

{$ALIGN 8}
  __MIDL_IWinTypes_0007 = record
    case Integer of
      0: (hInproc: Integer);
      1: (hRemote: ^_userBITMAP);
      2: (hInproc64: Int64);
  end;

{$ALIGN 4}
{$ALIGN 8}
  _userHBITMAP = record
    fContext: Integer;
    u: __MIDL_IWinTypes_0007;
  end;

{$ALIGN 1}
  tagPALETTEENTRY = record
    peRed: Byte;
    peGreen: Byte;
    peBlue: Byte;
    peFlags: Byte;
  end;

{$ALIGN 2}
  tagLOGPALETTE = record
    palVersion: Word;
    palNumEntries: Word;
    palPalEntry: ^tagPALETTEENTRY;
  end;

{$ALIGN 8}
  __MIDL_IWinTypes_0008 = record
    case Integer of
      0: (hInproc: Integer);
      1: (hRemote: ^tagLOGPALETTE);
      2: (hInproc64: Int64);
  end;

{$ALIGN 4}
{$ALIGN 8}
  _userHPALETTE = record
    fContext: Integer;
    u: __MIDL_IWinTypes_0008;
  end;

  _FLAGGED_BYTE_BLOB = record
    fFlags: LongWord;
    clSize: LongWord;
    abData: ^Byte;
  end;

{$ALIGN 8}
  __MIDL_IWinTypes_0003 = record
    case Integer of
      0: (hInproc: Integer);
      1: (hRemote: ^_FLAGGED_BYTE_BLOB);
      2: (hInproc64: Int64);
  end;

{$ALIGN 4}
{$ALIGN 8}
  _userHGLOBAL = record
    fContext: Integer;
    u: __MIDL_IWinTypes_0003;
  end;

  __MIDL_IAdviseSink_0002 = record
    case Integer of
      0: (hBitmap: ^_userHBITMAP);
      1: (hPalette: ^_userHPALETTE);
      2: (hGeneric: ^_userHGLOBAL);
  end;

  _GDI_OBJECT = record
    ObjectType: LongWord;
    u: __MIDL_IAdviseSink_0002;
  end;

  __MIDL_IAdviseSink_0003 = record
    case Integer of
      0: (hMetaFilePict: ^_userHMETAFILEPICT);
      1: (hHEnhMetaFile: ^_userHENHMETAFILE);
      2: (hGdiHandle: ^_GDI_OBJECT);
      3: (hGlobal: ^_userHGLOBAL);
      4: (lpszFileName: PWideChar);
      5: (pstm: ^_BYTE_BLOB);
      6: (pstg: ^_BYTE_BLOB);
  end;

  _STGMEDIUM_UNION = record
    tymed: LongWord;
    u: __MIDL_IAdviseSink_0003;
  end;

  _userSTGMEDIUM = record
    DUMMYUNIONNAME: _STGMEDIUM_UNION;
    pUnkForRelease: IUnknown;
  end;


  _userFLAG_STGMEDIUM = record
    ContextFlags: Integer;
    fPassOwnership: Integer;
    Stgmed: _userSTGMEDIUM;
  end;


  tagSTATDATA = record
    formatetc: tagFORMATETC;
    advf: LongWord;
    pAdvSink: IAdviseSink;
    dwConnection: LongWord;
  end;

  _POINTL = record
    x: Integer;
    y: Integer;
  end;

  DOMNodeType = tagDOMNodeType; 

  FOLDERSETTINGS = record
    ViewMode: SYSUINT;
    fFlags: SYSUINT;
  end;

  tagPOINT = record
    x: Integer;
    y: Integer;
  end;

  tagMSG = record
    hwnd: wireHWND;
    message: SYSUINT;
    wParam: LongWord;
    lParam: Integer;
    time: LongWord;
    pt: tagPOINT;
  end;


  tagOleMenuGroupWidths = record
    width: array[0..5] of Integer;
  end;

  UINT_PTR = LongWord; 

  DESKBANDINFO = record
    dwMask: LongWord;
    ptMinSize: _POINTL;
    ptMaxSize: _POINTL;
    ptIntegral: _POINTL;
    ptActual: _POINTL;
    wszTitle: array[0..255] of Word;
    dwModeFlags: LongWord;
    crBkgnd: LongWord;
  end;

  tagBANDSITEINFO = record
    dwMask: LongWord;
    dwState: LongWord;
    dwStyle: LongWord;
  end;

  _COMDLG_FILTERSPEC = record
    pszName: PWideChar;
    pszSpec: PWideChar;
  end;

  KNOWNFOLDER_DEFINITION = record
    category: KF_CATEGORY;
    pszName: PWideChar;
    pszDescription: PWideChar;
    fidParent: TGUID;
    pszRelativePath: PWideChar;
    pszParsingName: PWideChar;
    pszToolTip: PWideChar;
    pszLocalizedName: PWideChar;
    pszIcon: PWideChar;
    pszSecurity: PWideChar;
    dwAttributes: LongWord;
    kfdFlags: LongWord;
    ftidType: TGUID;
  end;

  SORTCOLUMN = record
    propkey: _tagpropertykey;
    direction: SYSINT;
  end;


{$ALIGN 8}
  tag_inner_PROPVARIANT = record
    vt: Word;
    wReserved1: Byte;
    wReserved2: Byte;
    wReserved3: LongWord;
    __MIDL____MIDL_itf_ShObjIdl_0001_01490001: __MIDL___MIDL_itf_ShObjIdl_0001_0149_0001;
  end;

{$ALIGN 8}
  __MIDL_IOleAutomationTypes_0004 = record
    case Integer of
      0: (llVal: Int64);
      1: (lVal: Integer);
      2: (bVal: Byte);
      3: (iVal: Smallint);
      4: (fltVal: Single);
      5: (dblVal: Double);
      6: (boolVal: WordBool);
      7: (scode: SCODE);
      8: (cyVal: Currency);
      9: (date: TDateTime);
      10: (bstrVal: ^_FLAGGED_WORD_BLOB);
      11: (punkVal: {!!IUnknown}Pointer);
      12: (pdispVal: {!!IDispatch}Pointer);
      13: (parray: ^PUserType6);
      14: (brecVal: ^_wireBRECORD);
      15: (pbVal: ^Byte);
      16: (piVal: ^Smallint);
      17: (plVal: ^Integer);
      18: (pllVal: ^Int64);
      19: (pfltVal: ^Single);
      20: (pdblVal: ^Double);
      21: (pboolVal: ^WordBool);
      22: (pscode: ^SCODE);
      23: (pcyVal: ^Currency);
      24: (pdate: ^TDateTime);
      25: (pbstrVal: ^PUserType7);
      26: (ppunkVal: {!!^IUnknown}Pointer);
      27: (ppdispVal: {!!^IDispatch}Pointer);
      28: (pparray: ^PPUserType2);
      29: (pvarVal: ^PUserType8);
      30: (cVal: Shortint);
      31: (uiVal: Word);
      32: (ulVal: LongWord);
      33: (ullVal: Largeuint);
      34: (intVal: SYSINT);
      35: (uintVal: SYSUINT);
      36: (decVal: TDecimal);
      37: (pdecVal: ^TDecimal);
      38: (pcVal: ^Shortint);
      39: (puiVal: ^Word);
      40: (pulVal: ^LongWord);
      41: (pullVal: ^Largeuint);
      42: (pintVal: ^SYSINT);
      43: (puintVal: ^SYSUINT);
  end;

{$ALIGN 4}
  __MIDL_IOleAutomationTypes_0001 = record
    case Integer of
      0: (BstrStr: _wireSAFEARR_BSTR);
      1: (UnknownStr: _wireSAFEARR_UNKNOWN);
      2: (DispatchStr: _wireSAFEARR_DISPATCH);
      3: (VariantStr: _wireSAFEARR_VARIANT);
      4: (RecordStr: _wireSAFEARR_BRECORD);
      5: (HaveIidStr: _wireSAFEARR_HAVEIID);
      6: (ByteStr: _BYTE_SIZEDARR);
      7: (WordStr: _SHORT_SIZEDARR);
      8: (LongStr: _LONG_SIZEDARR);
      9: (HyperStr: _HYPER_SIZEDARR);
  end;

  _wireSAFEARRAY_UNION = record
    sfType: LongWord;
    u: __MIDL_IOleAutomationTypes_0001;
  end;

{$ALIGN 8}
  _wireVARIANT = record
    clSize: LongWord;
    rpcReserved: LongWord;
    vt: Word;
    wReserved1: Word;
    wReserved2: Word;
    wReserved3: Word;
    DUMMYUNIONNAME: __MIDL_IOleAutomationTypes_0004;
  end;


  tagTYPEATTR = record
    guid: TGUID;
    lcid: LongWord;
    dwReserved: LongWord;
    memidConstructor: Integer;
    memidDestructor: Integer;
    lpstrSchema: PWideChar;
    cbSizeInstance: LongWord;
    typekind: tagTYPEKIND;
    cFuncs: Word;
    cVars: Word;
    cImplTypes: Word;
    cbSizeVft: Word;
    cbAlignment: Word;
    wTypeFlags: Word;
    wMajorVerNum: Word;
    wMinorVerNum: Word;
    tdescAlias: tagTYPEDESC;
    idldescType: tagIDLDESC;
  end;

  tagARRAYDESC = record
    tdescElem: tagTYPEDESC;
    cDims: Word;
    rgbounds: ^tagSAFEARRAYBOUND;
  end;


  _wireSAFEARRAY = record
    cDims: Word;
    fFeatures: Word;
    cbElements: LongWord;
    cLocks: LongWord;
    uArrayStructs: _wireSAFEARRAY_UNION;
    rgsabound: ^tagSAFEARRAYBOUND;
  end;


  IShellFolder = interface(IUnknown)
    ['{000214E6-0000-0000-C000-000000000046}']
    function ParseDisplayName(var hwnd: _RemotableHandle; const pbc: IBindCtx; 
                              pszDisplayName: PWideChar; var pchEaten: LongWord; 
                              out ppidl: wirePIDL; var pdwAttributes: LongWord): HResult; stdcall;
    function EnumObjects(var hwnd: _RemotableHandle; grfFlags: LongWord; 
                         out ppenumIDList: IEnumIDList): HResult; stdcall;
    function BindToObject(var pidl: _BYTE_BLOB; const pbc: IBindCtx; var riid: TGUID; 
                          out ppv: Pointer): HResult; stdcall;
    function BindToStorage(var pidl: _BYTE_BLOB; const pbc: IBindCtx; var riid: TGUID; 
                           out ppv: Pointer): HResult; stdcall;
    function CompareIDs(lParam: LONG_PTR; var pidl1: _BYTE_BLOB; var pidl2: _BYTE_BLOB): HResult; stdcall;
    function CreateViewObject(var hwndOwner: _RemotableHandle; var riid: TGUID; out ppv: Pointer): HResult; stdcall;
    function GetAttributesOf(cidl: SYSUINT; apidl: PPUserType1; var rgfInOut: LongWord): HResult; stdcall;
    function GetUIObjectOf(var hwndOwner: _RemotableHandle; cidl: SYSUINT; apidl: PPUserType1; 
                           var riid: TGUID; var rgfReserved: SYSUINT; out ppv: Pointer): HResult; stdcall;
    function GetDisplayNameOf(var pidl: _BYTE_BLOB; uFlags: LongWord; out pName: _STRRET): HResult; stdcall;
    function RemoteSetNameOf(var hwnd: _RemotableHandle; var pidl: _BYTE_BLOB; pszName: PWideChar; 
                             uFlags: LongWord; out ppidlOut: wirePIDL): HResult; stdcall;
  end;

  IShellFolder2 = interface(IShellFolder)
    ['{93F2F68C-1D1B-11D3-A30E-00C04F79ABD1}']
    function GetDefaultSearchGUID(out pguid: TGUID): HResult; stdcall;
    function EnumSearches(out ppenum: IEnumExtraSearch): HResult; stdcall;
    function GetDefaultColumn(dwRes: LongWord; out pSort: LongWord; out pDisplay: LongWord): HResult; stdcall;
    function GetDefaultColumnState(iColumn: SYSUINT; out pcsFlags: LongWord): HResult; stdcall;
    function GetDetailsEx(var pidl: _BYTE_BLOB; var pscid: _tagpropertykey; out pv: OleVariant): HResult; stdcall;
    function GetDetailsOf(var pidl: _BYTE_BLOB; iColumn: SYSUINT; out psd: _SHELLDETAILS): HResult; stdcall;
    function MapColumnToSCID(iColumn: SYSUINT; out pscid: _tagpropertykey): HResult; stdcall;
  end;

  IBindCtx = interface(IUnknown)
    ['{0000000E-0000-0000-C000-000000000046}']
    function RegisterObjectBound(const punk: IUnknown): HResult; stdcall;
    function RevokeObjectBound(const punk: IUnknown): HResult; stdcall;
    function ReleaseBoundObjects: HResult; stdcall;
    function RemoteSetBindOptions(var pbindopts: tagBIND_OPTS2): HResult; stdcall;
    function RemoteGetBindOptions(var pbindopts: tagBIND_OPTS2): HResult; stdcall;
    function GetRunningObjectTable(out pprot: IRunningObjectTable): HResult; stdcall;
    function RegisterObjectParam(pszKey: PWideChar; const punk: IUnknown): HResult; stdcall;
    function GetObjectParam(pszKey: PWideChar; out ppunk: IUnknown): HResult; stdcall;
    function EnumObjectParam(out ppenum: IEnumString): HResult; stdcall;
    function RevokeObjectParam(pszKey: PWideChar): HResult; stdcall;
  end;

  IRunningObjectTable = interface(IUnknown)
    ['{00000010-0000-0000-C000-000000000046}']
    function Register(grfFlags: LongWord; const punkObject: IUnknown; 
                      const pmkObjectName: IMoniker; out pdwRegister: LongWord): HResult; stdcall;
    function Revoke(dwRegister: LongWord): HResult; stdcall;
    function IsRunning(const pmkObjectName: IMoniker): HResult; stdcall;
    function GetObject(const pmkObjectName: IMoniker; out ppunkObject: IUnknown): HResult; stdcall;
    function NoteChangeTime(dwRegister: LongWord; var pFileTime: _FILETIME): HResult; stdcall;
    function GetTimeOfLastChange(const pmkObjectName: IMoniker; out pFileTime: _FILETIME): HResult; stdcall;
    function EnumRunning(out ppenumMoniker: IEnumMoniker): HResult; stdcall;
  end;

  IPersist = interface(IUnknown)
    ['{0000010C-0000-0000-C000-000000000046}']
    function GetClassID(out pClassID: TGUID): HResult; stdcall;
  end;

  IPersistStream = interface(IPersist)
    ['{00000109-0000-0000-C000-000000000046}']
    function IsDirty: HResult; stdcall;
    function Load(const pstm: IStream): HResult; stdcall;
    function Save(const pstm: IStream; fClearDirty: Integer): HResult; stdcall;
    function GetSizeMax(out pcbSize: _ULARGE_INTEGER): HResult; stdcall;
  end;

  IMoniker = interface(IPersistStream)
    ['{0000000F-0000-0000-C000-000000000046}']
    function RemoteBindToObject(const pbc: IBindCtx; const pmkToLeft: IMoniker; 
                                var riidResult: TGUID; out ppvResult: IUnknown): HResult; stdcall;
    function RemoteBindToStorage(const pbc: IBindCtx; const pmkToLeft: IMoniker; var riid: TGUID; 
                                 out ppvObj: IUnknown): HResult; stdcall;
    function Reduce(const pbc: IBindCtx; dwReduceHowFar: LongWord; var ppmkToLeft: IMoniker; 
                    out ppmkReduced: IMoniker): HResult; stdcall;
    function ComposeWith(const pmkRight: IMoniker; fOnlyIfNotGeneric: Integer; 
                         out ppmkComposite: IMoniker): HResult; stdcall;
    function Enum(fForward: Integer; out ppenumMoniker: IEnumMoniker): HResult; stdcall;
    function IsEqual(const pmkOtherMoniker: IMoniker): HResult; stdcall;
    function Hash(out pdwHash: LongWord): HResult; stdcall;
    function IsRunning(const pbc: IBindCtx; const pmkToLeft: IMoniker; 
                       const pmkNewlyRunning: IMoniker): HResult; stdcall;
    function GetTimeOfLastChange(const pbc: IBindCtx; const pmkToLeft: IMoniker; 
                                 out pFileTime: _FILETIME): HResult; stdcall;
    function Inverse(out ppmk: IMoniker): HResult; stdcall;
    function CommonPrefixWith(const pmkOther: IMoniker; out ppmkPrefix: IMoniker): HResult; stdcall;
    function RelativePathTo(const pmkOther: IMoniker; out ppmkRelPath: IMoniker): HResult; stdcall;
    function GetDisplayName(const pbc: IBindCtx; const pmkToLeft: IMoniker; 
                            out ppszDisplayName: PWideChar): HResult; stdcall;
    function ParseDisplayName(const pbc: IBindCtx; const pmkToLeft: IMoniker; 
                              pszDisplayName: PWideChar; out pchEaten: LongWord; 
                              out ppmkOut: IMoniker): HResult; stdcall;
    function IsSystemMoniker(out pdwMksys: LongWord): HResult; stdcall;
  end;

  ISequentialStream = interface(IUnknown)
    ['{0C733A30-2A1C-11CE-ADE5-00AA0044773D}']
    function RemoteRead(out pv: Byte; cb: LongWord; out pcbRead: LongWord): HResult; stdcall;
    function RemoteWrite(var pv: Byte; cb: LongWord; out pcbWritten: LongWord): HResult; stdcall;
  end;

  IStream = interface(ISequentialStream)
    ['{0000000C-0000-0000-C000-000000000046}']
    function RemoteSeek(dlibMove: _LARGE_INTEGER; dwOrigin: LongWord; 
                        out plibNewPosition: _ULARGE_INTEGER): HResult; stdcall;
    function SetSize(libNewSize: _ULARGE_INTEGER): HResult; stdcall;
    function RemoteCopyTo(const pstm: IStream; cb: _ULARGE_INTEGER; out pcbRead: _ULARGE_INTEGER; 
                          out pcbWritten: _ULARGE_INTEGER): HResult; stdcall;
    function Commit(grfCommitFlags: LongWord): HResult; stdcall;
    function Revert: HResult; stdcall;
    function LockRegion(libOffset: _ULARGE_INTEGER; cb: _ULARGE_INTEGER; dwLockType: LongWord): HResult; stdcall;
    function UnlockRegion(libOffset: _ULARGE_INTEGER; cb: _ULARGE_INTEGER; dwLockType: LongWord): HResult; stdcall;
    function Stat(out pstatstg: tagSTATSTG; grfStatFlag: LongWord): HResult; stdcall;
    function Clone(out ppstm: IStream): HResult; stdcall;
  end;

  IEnumMoniker = interface(IUnknown)
    ['{00000102-0000-0000-C000-000000000046}']
    function RemoteNext(celt: LongWord; out rgelt: IMoniker; out pceltFetched: LongWord): HResult; stdcall;
    function Skip(celt: LongWord): HResult; stdcall;
    function Reset: HResult; stdcall;
    function Clone(out ppenum: IEnumMoniker): HResult; stdcall;
  end;

  IEnumString = interface(IUnknown)
    ['{00000101-0000-0000-C000-000000000046}']
    function RemoteNext(celt: LongWord; out rgelt: PWideChar; out pceltFetched: LongWord): HResult; stdcall;
    function Skip(celt: LongWord): HResult; stdcall;
    function Reset: HResult; stdcall;
    function Clone(out ppenum: IEnumString): HResult; stdcall;
  end;

  IEnumIDList = interface(IUnknown)
    ['{000214F2-0000-0000-C000-000000000046}']
    function RemoteNext(celt: LongWord; out rgelt: wirePIDL; out pceltFetched: LongWord): HResult; stdcall;
    function Skip(celt: LongWord): HResult; stdcall;
    function Reset: HResult; stdcall;
    function Clone(out ppenum: IEnumIDList): HResult; stdcall;
  end;

  IEnumExtraSearch = interface(IUnknown)
    ['{0E700BE1-9DB6-11D1-A1CE-00C04FD75D13}']
    function Next(celt: LongWord; out rgelt: EXTRASEARCH; out pceltFetched: LongWord): HResult; stdcall;
    function Skip(celt: LongWord): HResult; stdcall;
    function Reset: HResult; stdcall;
    function Clone(out ppenum: IEnumExtraSearch): HResult; stdcall;
  end;

  IShellLinkW = interface(IUnknown)
    ['{000214F9-0000-0000-C000-000000000046}']
    function GetPath(pszFile: PWideChar; cch: SYSINT; var pfd: _WIN32_FIND_DATAW; fFlags: LongWord): HResult; stdcall;
    function GetIDList(out ppidl: wirePIDL): HResult; stdcall;
    function SetIDList(var pidl: _BYTE_BLOB): HResult; stdcall;
    function GetDescription(pszName: PWideChar; cch: SYSINT): HResult; stdcall;
    function SetDescription(pszName: PWideChar): HResult; stdcall;
    function GetWorkingDirectory(pszDir: PWideChar; cch: SYSINT): HResult; stdcall;
    function SetWorkingDirectory(pszDir: PWideChar): HResult; stdcall;
    function GetArguments(pszArgs: PWideChar; cch: SYSINT): HResult; stdcall;
    function SetArguments(pszArgs: PWideChar): HResult; stdcall;
    function GetHotkey(out pwHotkey: Word): HResult; stdcall;
    function SetHotkey(wHotkey: Word): HResult; stdcall;
    function GetShowCmd(out piShowCmd: SYSINT): HResult; stdcall;
    function SetShowCmd(iShowCmd: SYSINT): HResult; stdcall;
    function GetIconLocation(pszIconPath: PWideChar; cch: SYSINT; out piIcon: SYSINT): HResult; stdcall;
    function SetIconLocation(pszIconPath: PWideChar; iIcon: SYSINT): HResult; stdcall;
    function SetRelativePath(pszPathRel: PWideChar; dwReserved: LongWord): HResult; stdcall;
    function Resolve(var hwnd: _RemotableHandle; fFlags: LongWord): HResult; stdcall;
    function SetPath(pszFile: PWideChar): HResult; stdcall;
  end;

  IQueryCancelAutoPlay = interface(IUnknown)
    ['{DDEFE873-6997-4E68-BE26-39B633ADBE12}']
    function AllowAutoPlay(pszPath: PWideChar; dwContentType: LongWord; pszLabel: PWideChar; 
                           dwSerialNumber: LongWord): HResult; stdcall;
  end;

  ICategorizer = interface(IUnknown)
    ['{A3B14589-9174-49A8-89A3-06A1AE2B9BA7}']
    function GetDescription(pszDesc: PWideChar; cch: SYSUINT): HResult; stdcall;
    function GetCategory(cidl: SYSUINT; apidl: PPUserType1; out rgCategoryIds: LongWord): HResult; stdcall;
    function GetCategoryInfo(dwCategoryId: LongWord; out pci: CATEGORY_INFO): HResult; stdcall;
    function CompareCategory(csfFlags: CATSORT_FLAGS; dwCategoryId1: LongWord; 
                             dwCategoryId2: LongWord): HResult; stdcall;
  end;

  IPersistFile = interface(IPersist)
    ['{0000010B-0000-0000-C000-000000000046}']
    function IsDirty: HResult; stdcall;
    function Load(pszFileName: PWideChar; dwMode: LongWord): HResult; stdcall;
    function Save(pszFileName: PWideChar; fRemember: Integer): HResult; stdcall;
    function SaveCompleted(pszFileName: PWideChar): HResult; stdcall;
    function GetCurFile(out ppszFileName: PWideChar): HResult; stdcall;
  end;

  IPropertyUI = interface(IUnknown)
    ['{757A7D9F-919A-4118-99D7-DBB208C8CC66}']
    function ParsePropertyName(pszName: PWideChar; out pfmtid: TGUID; out ppid: LongWord; 
                               var pchEaten: LongWord): HResult; stdcall;
    function GetCannonicalName(var fmtid: TGUID; pid: LongWord; pwszText: PWideChar; 
                               cchText: LongWord): HResult; stdcall;
    function GetDisplayName(var fmtid: TGUID; pid: LongWord; Flags: LongWord; pwszText: PWideChar; 
                            cchText: LongWord): HResult; stdcall;
    function GetPropertyDescription(var fmtid: TGUID; pid: LongWord; pwszText: PWideChar; 
                                    cchText: LongWord): HResult; stdcall;
    function GetDefaultWidth(var fmtid: TGUID; pid: LongWord; out pcxChars: LongWord): HResult; stdcall;
    function GetFlags(var fmtid: TGUID; pid: LongWord; out pflags: LongWord): HResult; stdcall;
    function FormatForDisplay(var fmtid: TGUID; pid: LongWord; var ppropvar: tag_inner_PROPVARIANT; 
                              puiff: LongWord; pwszText: PWideChar; cchText: LongWord): HResult; stdcall;
    function GetHelpInfo(var fmtid: TGUID; pid: LongWord; pwszHelpFile: PWideChar; cch: LongWord; 
                         out puHelpID: SYSUINT): HResult; stdcall;
  end;

  IStorage = interface(IUnknown)
    ['{0000000B-0000-0000-C000-000000000046}']
    function CreateStream(pwcsName: PWideChar; grfMode: LongWord; reserved1: LongWord; 
                          reserved2: LongWord; out ppstm: IStream): HResult; stdcall;
    function RemoteOpenStream(pwcsName: PWideChar; cbReserved1: LongWord; var reserved1: Byte; 
                              grfMode: LongWord; reserved2: LongWord; out ppstm: IStream): HResult; stdcall;
    function CreateStorage(pwcsName: PWideChar; grfMode: LongWord; reserved1: LongWord; 
                           reserved2: LongWord; out ppstg: IStorage): HResult; stdcall;
    function OpenStorage(pwcsName: PWideChar; const pstgPriority: IStorage; grfMode: LongWord; 
                         var snbExclude: tagRemSNB; reserved: LongWord; out ppstg: IStorage): HResult; stdcall;
    function RemoteCopyTo(ciidExclude: LongWord; var rgiidExclude: TGUID; 
                          var snbExclude: tagRemSNB; const pstgDest: IStorage): HResult; stdcall;
    function MoveElementTo(pwcsName: PWideChar; const pstgDest: IStorage; pwcsNewName: PWideChar; 
                           grfFlags: LongWord): HResult; stdcall;
    function Commit(grfCommitFlags: LongWord): HResult; stdcall;
    function Revert: HResult; stdcall;
    function RemoteEnumElements(reserved1: LongWord; cbReserved2: LongWord; var reserved2: Byte; 
                                reserved3: LongWord; out ppenum: IEnumSTATSTG): HResult; stdcall;
    function DestroyElement(pwcsName: PWideChar): HResult; stdcall;
    function RenameElement(pwcsOldName: PWideChar; pwcsNewName: PWideChar): HResult; stdcall;
    function SetElementTimes(pwcsName: PWideChar; var pctime: _FILETIME; var patime: _FILETIME; 
                             var pmtime: _FILETIME): HResult; stdcall;
    function SetClass(var clsid: TGUID): HResult; stdcall;
    function SetStateBits(grfStateBits: LongWord; grfMask: LongWord): HResult; stdcall;
    function Stat(out pstatstg: tagSTATSTG; grfStatFlag: LongWord): HResult; stdcall;
  end;

  IEnumSTATSTG = interface(IUnknown)
    ['{0000000D-0000-0000-C000-000000000046}']
    function RemoteNext(celt: LongWord; out rgelt: tagSTATSTG; out pceltFetched: LongWord): HResult; stdcall;
    function Skip(celt: LongWord): HResult; stdcall;
    function Reset: HResult; stdcall;
    function Clone(out ppenum: IEnumSTATSTG): HResult; stdcall;
  end;

  IRecordInfo = interface(IUnknown)
    ['{0000002F-0000-0000-C000-000000000046}']
    function RecordInit(out pvNew: Pointer): HResult; stdcall;
    function RecordClear(var pvExisting: Pointer): HResult; stdcall;
    function RecordCopy(var pvExisting: Pointer; out pvNew: Pointer): HResult; stdcall;
    function GetGuid(out pguid: TGUID): HResult; stdcall;
    function GetName(out pbstrName: WideString): HResult; stdcall;
    function GetSize(out pcbSize: LongWord): HResult; stdcall;
    function GetTypeInfo(out ppTypeInfo: ITypeInfo): HResult; stdcall;
    function GetField(var pvData: Pointer; szFieldName: PWideChar; out pvarField: OleVariant): HResult; stdcall;
    function GetFieldNoCopy(var pvData: Pointer; szFieldName: PWideChar; out pvarField: OleVariant; 
                            out ppvDataCArray: Pointer): HResult; stdcall;
    function PutField(wFlags: LongWord; var pvData: Pointer; szFieldName: PWideChar; 
                      var pvarField: OleVariant): HResult; stdcall;
    function PutFieldNoCopy(wFlags: LongWord; var pvData: Pointer; szFieldName: PWideChar; 
                            var pvarField: OleVariant): HResult; stdcall;
    function GetFieldNames(var pcNames: LongWord; out rgBstrNames: WideString): HResult; stdcall;
    function IsMatchingType(const pRecordInfo: IRecordInfo): Integer; stdcall;
    function RecordCreate: Pointer; stdcall;
    function RecordCreateCopy(var pvSource: Pointer; out ppvDest: Pointer): HResult; stdcall;
    function RecordDestroy(var pvRecord: Pointer): HResult; stdcall;
  end;

  ITypeInfo = interface(IUnknown)
    ['{00020401-0000-0000-C000-000000000046}']
    function RemoteGetTypeAttr(out ppTypeAttr: PUserType9; out pDummy: DWORD): HResult; stdcall;
    function GetTypeComp(out ppTComp: ITypeComp): HResult; stdcall;
    function RemoteGetFuncDesc(index: SYSUINT; out ppFuncDesc: PUserType10; out pDummy: DWORD): HResult; stdcall;
    function RemoteGetVarDesc(index: SYSUINT; out ppVarDesc: PUserType11; out pDummy: DWORD): HResult; stdcall;
    function RemoteGetNames(memid: Integer; out rgBstrNames: WideString; cMaxNames: SYSUINT; 
                            out pcNames: SYSUINT): HResult; stdcall;
    function GetRefTypeOfImplType(index: SYSUINT; out pRefType: LongWord): HResult; stdcall;
    function GetImplTypeFlags(index: SYSUINT; out pImplTypeFlags: SYSINT): HResult; stdcall;
    function LocalGetIDsOfNames: HResult; stdcall;
    function LocalInvoke: HResult; stdcall;
    function RemoteGetDocumentation(memid: Integer; refPtrFlags: LongWord; 
                                    out pbstrName: WideString; out pBstrDocString: WideString; 
                                    out pdwHelpContext: LongWord; out pBstrHelpFile: WideString): HResult; stdcall;
    function RemoteGetDllEntry(memid: Integer; invkind: tagINVOKEKIND; refPtrFlags: LongWord; 
                               out pBstrDllName: WideString; out pbstrName: WideString; 
                               out pwOrdinal: Word): HResult; stdcall;
    function GetRefTypeInfo(hreftype: LongWord; out ppTInfo: ITypeInfo): HResult; stdcall;
    function LocalAddressOfMember: HResult; stdcall;
    function RemoteCreateInstance(var riid: TGUID; out ppvObj: IUnknown): HResult; stdcall;
    function GetMops(memid: Integer; out pBstrMops: WideString): HResult; stdcall;
    function RemoteGetContainingTypeLib(out ppTLib: ITypeLib; out pIndex: SYSUINT): HResult; stdcall;
    function LocalReleaseTypeAttr: HResult; stdcall;
    function LocalReleaseFuncDesc: HResult; stdcall;
    function LocalReleaseVarDesc: HResult; stdcall;
  end;

  ITypeComp = interface(IUnknown)
    ['{00020403-0000-0000-C000-000000000046}']
    function RemoteBind(szName: PWideChar; lHashVal: LongWord; wFlags: Word; 
                        out ppTInfo: ITypeInfo; out pDescKind: tagDESCKIND; 
                        out ppFuncDesc: PUserType10; out ppVarDesc: PUserType11; 
                        out ppTypeComp: ITypeComp; out pDummy: DWORD): HResult; stdcall;
    function RemoteBindType(szName: PWideChar; lHashVal: LongWord; out ppTInfo: ITypeInfo): HResult; stdcall;
  end;

  ITypeLib = interface(IUnknown)
    ['{00020402-0000-0000-C000-000000000046}']
    function RemoteGetTypeInfoCount(out pcTInfo: SYSUINT): HResult; stdcall;
    function GetTypeInfo(index: SYSUINT; out ppTInfo: ITypeInfo): HResult; stdcall;
    function GetTypeInfoType(index: SYSUINT; out pTKind: tagTYPEKIND): HResult; stdcall;
    function GetTypeInfoOfGuid(var guid: TGUID; out ppTInfo: ITypeInfo): HResult; stdcall;
    function RemoteGetLibAttr(out ppTLibAttr: PUserType14; out pDummy: DWORD): HResult; stdcall;
    function GetTypeComp(out ppTComp: ITypeComp): HResult; stdcall;
    function RemoteGetDocumentation(index: SYSINT; refPtrFlags: LongWord; 
                                    out pbstrName: WideString; out pBstrDocString: WideString; 
                                    out pdwHelpContext: LongWord; out pBstrHelpFile: WideString): HResult; stdcall;
    function RemoteIsName(szNameBuf: PWideChar; lHashVal: LongWord; out pfName: Integer; 
                          out pBstrLibName: WideString): HResult; stdcall;
    function RemoteFindName(szNameBuf: PWideChar; lHashVal: LongWord; out ppTInfo: ITypeInfo; 
                            out rgMemId: Integer; var pcFound: Word; out pBstrLibName: WideString): HResult; stdcall;
    function LocalReleaseTLibAttr: HResult; stdcall;
  end;

  IUserNotification = interface(IUnknown)
    ['{BA9711BA-5893-4787-A7E1-41277151550B}']
    function SetBalloonInfo(pszTitle: PWideChar; pszText: PWideChar; dwInfoFlags: LongWord): HResult; stdcall;
    function SetBalloonRetry(dwShowTime: LongWord; dwInterval: LongWord; cRetryCount: SYSUINT): HResult; stdcall;
    function SetIconInfo(var hIcon: _RemotableHandle; pszToolTip: PWideChar): HResult; stdcall;
    function Show(const pqc: IQueryContinue; dwContinuePollInterval: LongWord): HResult; stdcall;
    function PlaySound(pszSoundName: PWideChar): HResult; stdcall;
  end;

  IQueryContinue = interface(IUnknown)
    ['{7307055C-B24A-486B-9F25-163E597A28A9}']
    function QueryContinue: HResult; stdcall;
  end;

  ICDBurn = interface(IUnknown)
    ['{3D73A659-E5D0-4D42-AFC0-5121BA425C8D}']
    function GetRecorderDriveLetter(pszDrive: PWideChar; cch: SYSUINT): HResult; stdcall;
    function Burn(var hwnd: _RemotableHandle): HResult; stdcall;
    function HasRecordableDrive(out pfHasRecorder: Integer): HResult; stdcall;
  end;

  ITaskbarList = interface(IUnknown)
    ['{56FDF342-FD6D-11D0-958A-006097C9A090}']
    function HrInit: HResult; stdcall;
    function AddTab(var hwnd: _RemotableHandle): HResult; stdcall;
    function DeleteTab(var hwnd: _RemotableHandle): HResult; stdcall;
    function ActivateTab(var hwnd: _RemotableHandle): HResult; stdcall;
    function SetActiveAlt(var hwnd: _RemotableHandle): HResult; stdcall;
  end;

  ITaskbarList2 = interface(ITaskbarList)
    ['{602D4995-B13A-429B-A66E-1935E44F4317}']
    function MarkFullscreenWindow(var hwnd: _RemotableHandle; fFullscreen: Integer): HResult; stdcall;
  end;

  ITaskbarList3 = interface(ITaskbarList2)
    ['{EA1AFB91-9E28-4B86-90E9-9E9F8A5EEFAF}']
    function SetProgressValue(var hwnd: _RemotableHandle; ullCompleted: Largeuint; 
                              ullTotal: Largeuint): HResult; stdcall;
    function SetProgressState(var hwnd: _RemotableHandle; tbpFlags: TBPFLAG): HResult; stdcall;
    function RegisterTab(var hwndTab: _RemotableHandle; var hwndMDI: _RemotableHandle): HResult; stdcall;
    function UnregisterTab(var hwndTab: _RemotableHandle): HResult; stdcall;
    function SetTabOrder(var hwndTab: _RemotableHandle; var hwndInsertBefore: _RemotableHandle): HResult; stdcall;
    function SetTabActive(var hwndTab: _RemotableHandle; var hwndMDI: _RemotableHandle; 
                          dwReserved: LongWord): HResult; stdcall;
    function ThumbBarAddButtons(var hwnd: _RemotableHandle; cButtons: SYSUINT; 
                                var pButton: THUMBBUTTON): HResult; stdcall;
    function ThumbBarUpdateButtons(var hwnd: _RemotableHandle; cButtons: SYSUINT; 
                                   var pButton: THUMBBUTTON): HResult; stdcall;
    function ThumbBarSetImageList(var hwnd: _RemotableHandle; const himl: IUnknown): HResult; stdcall;
    function SetOverlayIcon(var hwnd: _RemotableHandle; var hIcon: _RemotableHandle; 
                            pszDescription: PWideChar): HResult; stdcall;
    function SetThumbnailTooltip(var hwnd: _RemotableHandle; pszTip: PWideChar): HResult; stdcall;
    function SetThumbnailClip(var hwnd: _RemotableHandle; var prcClip: tagRECT): HResult; stdcall;
  end;

  ITaskbarList4 = interface(ITaskbarList3)
    ['{C43DC798-95D1-4BEA-9030-BB99E2983A1A}']
    function SetTabProperties(var hwndTab: _RemotableHandle; stpFlags: STPFLAG): HResult; stdcall;
  end;

  IStartMenuPinnedList = interface(IUnknown)
    ['{4CD19ADA-25A5-4A32-B3B7-347BEE5BE36B}']
    function RemoveFromList(const pitem: IShellItem): HResult; stdcall;
  end;

  IShellItem = interface(IUnknown)
    ['{43826D1E-E718-42EE-BC55-A1E261C37BFE}']
    function BindToHandler(const pbc: IBindCtx; var bhid: TGUID; var riid: TGUID; out ppv: Pointer): HResult; stdcall;
    function GetParent(out ppsi: IShellItem): HResult; stdcall;
    function GetDisplayName(sigdnName: _SIGDN; out ppszName: PWideChar): HResult; stdcall;
    function GetAttributes(sfgaoMask: LongWord; out psfgaoAttribs: LongWord): HResult; stdcall;
    function Compare(const psi: IShellItem; hint: LongWord; out piOrder: SYSINT): HResult; stdcall;
  end;

  IWizardExtension = interface(IUnknown)
    ['{C02EA696-86CC-491E-9B23-74394A0444A8}']
    function AddPages(out aPages: Pointer; cPages: SYSUINT; out pnPagesAdded: SYSUINT): HResult; stdcall;
    function GetFirstPage(out phpage: Pointer): HResult; stdcall;
    function GetLastPage(out phpage: Pointer): HResult; stdcall;
  end;

  IWebWizardExtension = interface(IWizardExtension)
    ['{0E6B3F66-98D1-48C0-A222-FBDE74E2FBC5}']
    function SetInitialURL(pszURL: PWideChar): HResult; stdcall;
    function SetErrorURL(pszErrorURL: PWideChar): HResult; stdcall;
  end;

  IDropTarget = interface(IUnknown)
    ['{00000122-0000-0000-C000-000000000046}']
    function DragEnter(const pDataObj: IDataObject; grfKeyState: LongWord; pt: _POINTL; 
                       var pdwEffect: LongWord): HResult; stdcall;
    function DragOver(grfKeyState: LongWord; pt: _POINTL; var pdwEffect: LongWord): HResult; stdcall;
    function DragLeave: HResult; stdcall;
    function Drop(const pDataObj: IDataObject; grfKeyState: LongWord; pt: _POINTL; 
                  var pdwEffect: LongWord): HResult; stdcall;
  end;

  IDataObject = interface(IUnknown)
    ['{0000010E-0000-0000-C000-000000000046}']
    function RemoteGetData(var pformatetcIn: tagFORMATETC; out pRemoteMedium: wireSTGMEDIUM): HResult; stdcall;
    function RemoteGetDataHere(var pformatetc: tagFORMATETC; var pRemoteMedium: wireSTGMEDIUM): HResult; stdcall;
    function QueryGetData(var pformatetc: tagFORMATETC): HResult; stdcall;
    function GetCanonicalFormatEtc(var pformatectIn: tagFORMATETC; out pformatetcOut: tagFORMATETC): HResult; stdcall;
    function RemoteSetData(var pformatetc: tagFORMATETC; pmedium: PPUserType3; fRelease: Integer): HResult; stdcall;
    function EnumFormatEtc(dwDirection: LongWord; out ppenumFormatEtc: IEnumFORMATETC): HResult; stdcall;
    function DAdvise(var pformatetc: tagFORMATETC; advf: LongWord; const pAdvSink: IAdviseSink; 
                     out pdwConnection: LongWord): HResult; stdcall;
    function DUnadvise(dwConnection: LongWord): HResult; stdcall;
    function EnumDAdvise(out ppenumAdvise: IEnumSTATDATA): HResult; stdcall;
  end;

  IEnumFORMATETC = interface(IUnknown)
    ['{00000103-0000-0000-C000-000000000046}']
    function RemoteNext(celt: LongWord; out rgelt: tagFORMATETC; out pceltFetched: LongWord): HResult; stdcall;
    function Skip(celt: LongWord): HResult; stdcall;
    function Reset: HResult; stdcall;
    function Clone(out ppenum: IEnumFORMATETC): HResult; stdcall;
  end;

  IAdviseSink = interface(IUnknown)
    ['{0000010F-0000-0000-C000-000000000046}']
    function RemoteOnDataChange(var pformatetc: tagFORMATETC; pStgmed: PPUserType4): HResult; stdcall;
    function RemoteOnViewChange(dwAspect: LongWord; lindex: Integer): HResult; stdcall;
    function RemoteOnRename(const pmk: IMoniker): HResult; stdcall;
    function RemoteOnSave: HResult; stdcall;
    function RemoteOnClose: HResult; stdcall;
  end;

  IEnumSTATDATA = interface(IUnknown)
    ['{00000105-0000-0000-C000-000000000046}']
    function RemoteNext(celt: LongWord; out rgelt: tagSTATDATA; out pceltFetched: LongWord): HResult; stdcall;
    function Skip(celt: LongWord): HResult; stdcall;
    function Reset: HResult; stdcall;
    function Clone(out ppenum: IEnumSTATDATA): HResult; stdcall;
  end;

  IPublishingWizard = interface(IWizardExtension)
    ['{AA9198BB-CCEC-472D-BEED-19A4F6733F7A}']
    function Initialize(const pdo: IDataObject; dwOptions: LongWord; pszServiceScope: PWideChar): HResult; stdcall;
    function GetTransferManifest(out phrFromTransfer: HResult; out pdocManifest: IXMLDOMDocument): HResult; stdcall;
  end;

  IXMLDOMNode = interface(IDispatch)
    ['{2933BF80-7B36-11D2-B20E-00C04F983E60}']
    function Get_nodeName: WideString; safecall;
    function Get_nodeValue: OleVariant; safecall;
    procedure Set_nodeValue(value: OleVariant); safecall;
    function Get_nodeType: DOMNodeType; safecall;
    function Get_parentNode: IXMLDOMNode; safecall;
    function Get_childNodes: PPUserType16; safecall;
    function Get_firstChild: IXMLDOMNode; safecall;
    function Get_lastChild: IXMLDOMNode; safecall;
    function Get_previousSibling: IXMLDOMNode; safecall;
    function Get_nextSibling: IXMLDOMNode; safecall;
    function Get_attributes: PPUserType17; safecall;
    function insertBefore(const newChild: IXMLDOMNode; refChild: OleVariant): IXMLDOMNode; safecall;
    function replaceChild(const newChild: IXMLDOMNode; const oldChild: IXMLDOMNode): IXMLDOMNode; safecall;
    function removeChild(const childNode: IXMLDOMNode): IXMLDOMNode; safecall;
    function appendChild(const newChild: IXMLDOMNode): IXMLDOMNode; safecall;
    function hasChildNodes: WordBool; safecall;
    function Get_ownerDocument: PPUserType18; safecall;
    function cloneNode(deep: WordBool): IXMLDOMNode; safecall;
    function Get_nodeTypeString: WideString; safecall;
    function Get_text: WideString; safecall;
    procedure Set_text(const text: WideString); safecall;
    function Get_specified: WordBool; safecall;
    function Get_definition: IXMLDOMNode; safecall;
    function Get_nodeTypedValue: OleVariant; safecall;
    procedure Set_nodeTypedValue(typedValue: OleVariant); safecall;
    function Get_dataType: OleVariant; safecall;
    procedure Set_dataType(const dataTypeName: WideString); safecall;
    function Get_xml: WideString; safecall;
    function transformNode(const stylesheet: IXMLDOMNode): WideString; safecall;
    function selectNodes(const queryString: WideString): IXMLDOMNodeList; safecall;
    function selectSingleNode(const queryString: WideString): IXMLDOMNode; safecall;
    function Get_parsed: WordBool; safecall;
    function Get_namespaceURI: WideString; safecall;
    function Get_prefix: WideString; safecall;
    function Get_baseName: WideString; safecall;
    procedure transformNodeToObject(const stylesheet: IXMLDOMNode; outputObject: OleVariant); safecall;
    property nodeName: WideString read Get_nodeName;
    property nodeValue: OleVariant read Get_nodeValue write Set_nodeValue;
    property nodeType: DOMNodeType read Get_nodeType;
    property parentNode: IXMLDOMNode read Get_parentNode;
    property childNodes: PPUserType16 read Get_childNodes;
    property firstChild: IXMLDOMNode read Get_firstChild;
    property lastChild: IXMLDOMNode read Get_lastChild;
    property previousSibling: IXMLDOMNode read Get_previousSibling;
    property nextSibling: IXMLDOMNode read Get_nextSibling;
    property attributes: PPUserType17 read Get_attributes;
    property ownerDocument: PPUserType18 read Get_ownerDocument;
    property nodeTypeString: WideString read Get_nodeTypeString;
    property text: WideString read Get_text write Set_text;
    property specified: WordBool read Get_specified;
    property definition: IXMLDOMNode read Get_definition;
    property nodeTypedValue: OleVariant read Get_nodeTypedValue write Set_nodeTypedValue;
    property xml: WideString read Get_xml;
    property parsed: WordBool read Get_parsed;
    property namespaceURI: WideString read Get_namespaceURI;
    property prefix: WideString read Get_prefix;
    property baseName: WideString read Get_baseName;
  end;

  IXMLDOMNodeDisp = dispinterface
    ['{2933BF80-7B36-11D2-B20E-00C04F983E60}']
    property nodeName: WideString readonly dispid 2;
    property nodeValue: OleVariant dispid 3;
    property nodeType: DOMNodeType readonly dispid 4;
    property parentNode: IXMLDOMNode readonly dispid 6;
    property childNodes: {??PPUserType16}OleVariant readonly dispid 7;
    property firstChild: IXMLDOMNode readonly dispid 8;
    property lastChild: IXMLDOMNode readonly dispid 9;
    property previousSibling: IXMLDOMNode readonly dispid 10;
    property nextSibling: IXMLDOMNode readonly dispid 11;
    property attributes: {??PPUserType17}OleVariant readonly dispid 12;
    function insertBefore(const newChild: IXMLDOMNode; refChild: OleVariant): IXMLDOMNode; dispid 13;
    function replaceChild(const newChild: IXMLDOMNode; const oldChild: IXMLDOMNode): IXMLDOMNode; dispid 14;
    function removeChild(const childNode: IXMLDOMNode): IXMLDOMNode; dispid 15;
    function appendChild(const newChild: IXMLDOMNode): IXMLDOMNode; dispid 16;
    function hasChildNodes: WordBool; dispid 17;
    property ownerDocument: {??PPUserType18}OleVariant readonly dispid 18;
    function cloneNode(deep: WordBool): IXMLDOMNode; dispid 19;
    property nodeTypeString: WideString readonly dispid 21;
    property text: WideString dispid 24;
    property specified: WordBool readonly dispid 22;
    property definition: IXMLDOMNode readonly dispid 23;
    property nodeTypedValue: OleVariant dispid 25;
    function dataType: OleVariant; dispid 26;
    property xml: WideString readonly dispid 27;
    function transformNode(const stylesheet: IXMLDOMNode): WideString; dispid 28;
    function selectNodes(const queryString: WideString): IXMLDOMNodeList; dispid 29;
    function selectSingleNode(const queryString: WideString): IXMLDOMNode; dispid 30;
    property parsed: WordBool readonly dispid 31;
    property namespaceURI: WideString readonly dispid 32;
    property prefix: WideString readonly dispid 33;
    property baseName: WideString readonly dispid 34;
    procedure transformNodeToObject(const stylesheet: IXMLDOMNode; outputObject: OleVariant); dispid 35;
  end;

  IXMLDOMDocument = interface(IXMLDOMNode)
    ['{2933BF81-7B36-11D2-B20E-00C04F983E60}']
    function Get_doctype: PPUserType5; safecall;
    function Get_implementation_: PPUserType6; safecall;
    function Get_documentElement: PPUserType7; safecall;
    procedure _Set_documentElement(const DOMElement: IXMLDOMElement); safecall;
    function createElement(const tagName: WideString): IXMLDOMElement; safecall;
    function createDocumentFragment: PPUserType8; safecall;
    function createTextNode(const data: WideString): PPUserType9; safecall;
    function createComment(const data: WideString): PPUserType10; safecall;
    function createCDATASection(const data: WideString): PPUserType11; safecall;
    function createProcessingInstruction(const target: WideString; const data: WideString): PPUserType12; safecall;
    function createAttribute(const name: WideString): PPUserType13; safecall;
    function createEntityReference(const name: WideString): PPUserType14; safecall;
    function getElementsByTagName(const tagName: WideString): IXMLDOMNodeList; safecall;
    function createNode(type_: OleVariant; const name: WideString; const namespaceURI: WideString): IXMLDOMNode; safecall;
    function nodeFromID(const idString: WideString): IXMLDOMNode; safecall;
    function Load(xmlSource: OleVariant): WordBool; safecall;
    function Get_readyState: Integer; safecall;
    function Get_parseError: PPUserType15; safecall;
    function Get_url: WideString; safecall;
    function Get_async: WordBool; safecall;
    procedure Set_async(isAsync: WordBool); safecall;
    procedure abort; safecall;
    function loadXML(const bstrXML: WideString): WordBool; safecall;
    procedure Save(desination: OleVariant); safecall;
    function Get_validateOnParse: WordBool; safecall;
    procedure Set_validateOnParse(isValidating: WordBool); safecall;
    function Get_resolveExternals: WordBool; safecall;
    procedure Set_resolveExternals(isResolving: WordBool); safecall;
    function Get_preserveWhiteSpace: WordBool; safecall;
    procedure Set_preserveWhiteSpace(isPreserving: WordBool); safecall;
    procedure Set_onreadystatechange(Param1: OleVariant); safecall;
    procedure Set_ondataavailable(Param1: OleVariant); safecall;
    procedure Set_ontransformnode(Param1: OleVariant); safecall;
    property doctype: PPUserType5 read Get_doctype;
    property implementation_: PPUserType6 read Get_implementation_;
    property readyState: Integer read Get_readyState;
    property parseError: PPUserType15 read Get_parseError;
    property url: WideString read Get_url;
    property async: WordBool read Get_async write Set_async;
    property validateOnParse: WordBool read Get_validateOnParse write Set_validateOnParse;
    property resolveExternals: WordBool read Get_resolveExternals write Set_resolveExternals;
    property preserveWhiteSpace: WordBool read Get_preserveWhiteSpace write Set_preserveWhiteSpace;
    property onreadystatechange: OleVariant write Set_onreadystatechange;
    property ondataavailable: OleVariant write Set_ondataavailable;
    property ontransformnode: OleVariant write Set_ontransformnode;
  end;

  IXMLDOMDocumentDisp = dispinterface
    ['{2933BF81-7B36-11D2-B20E-00C04F983E60}']
    property doctype: {??PPUserType5}OleVariant readonly dispid 38;
    property implementation_: {??PPUserType6}OleVariant readonly dispid 39;
    function documentElement: {??PPUserType7}OleVariant; dispid 40;
    function createElement(const tagName: WideString): IXMLDOMElement; dispid 41;
    function createDocumentFragment: {??PPUserType8}OleVariant; dispid 42;
    function createTextNode(const data: WideString): {??PPUserType9}OleVariant; dispid 43;
    function createComment(const data: WideString): {??PPUserType10}OleVariant; dispid 44;
    function createCDATASection(const data: WideString): {??PPUserType11}OleVariant; dispid 45;
    function createProcessingInstruction(const target: WideString; const data: WideString): {??PPUserType12}OleVariant; dispid 46;
    function createAttribute(const name: WideString): {??PPUserType13}OleVariant; dispid 47;
    function createEntityReference(const name: WideString): {??PPUserType14}OleVariant; dispid 49;
    function getElementsByTagName(const tagName: WideString): IXMLDOMNodeList; dispid 50;
    function createNode(type_: OleVariant; const name: WideString; const namespaceURI: WideString): IXMLDOMNode; dispid 54;
    function nodeFromID(const idString: WideString): IXMLDOMNode; dispid 56;
    function Load(xmlSource: OleVariant): WordBool; dispid 58;
    property readyState: Integer readonly dispid -525;
    property parseError: {??PPUserType15}OleVariant readonly dispid 59;
    property url: WideString readonly dispid 60;
    property async: WordBool dispid 61;
    procedure abort; dispid 62;
    function loadXML(const bstrXML: WideString): WordBool; dispid 63;
    procedure Save(desination: OleVariant); dispid 64;
    property validateOnParse: WordBool dispid 65;
    property resolveExternals: WordBool dispid 66;
    property preserveWhiteSpace: WordBool dispid 67;
    property onreadystatechange: OleVariant writeonly dispid 68;
    property ondataavailable: OleVariant writeonly dispid 69;
    property ontransformnode: OleVariant writeonly dispid 70;
    property nodeName: WideString readonly dispid 2;
    property nodeValue: OleVariant dispid 3;
    property nodeType: DOMNodeType readonly dispid 4;
    property parentNode: IXMLDOMNode readonly dispid 6;
    property childNodes: {??PPUserType16}OleVariant readonly dispid 7;
    property firstChild: IXMLDOMNode readonly dispid 8;
    property lastChild: IXMLDOMNode readonly dispid 9;
    property previousSibling: IXMLDOMNode readonly dispid 10;
    property nextSibling: IXMLDOMNode readonly dispid 11;
    property attributes: {??PPUserType17}OleVariant readonly dispid 12;
    function insertBefore(const newChild: IXMLDOMNode; refChild: OleVariant): IXMLDOMNode; dispid 13;
    function replaceChild(const newChild: IXMLDOMNode; const oldChild: IXMLDOMNode): IXMLDOMNode; dispid 14;
    function removeChild(const childNode: IXMLDOMNode): IXMLDOMNode; dispid 15;
    function appendChild(const newChild: IXMLDOMNode): IXMLDOMNode; dispid 16;
    function hasChildNodes: WordBool; dispid 17;
    property ownerDocument: {??PPUserType18}OleVariant readonly dispid 18;
    function cloneNode(deep: WordBool): IXMLDOMNode; dispid 19;
    property nodeTypeString: WideString readonly dispid 21;
    property text: WideString dispid 24;
    property specified: WordBool readonly dispid 22;
    property definition: IXMLDOMNode readonly dispid 23;
    property nodeTypedValue: OleVariant dispid 25;
    function dataType: OleVariant; dispid 26;
    property xml: WideString readonly dispid 27;
    function transformNode(const stylesheet: IXMLDOMNode): WideString; dispid 28;
    function selectNodes(const queryString: WideString): IXMLDOMNodeList; dispid 29;
    function selectSingleNode(const queryString: WideString): IXMLDOMNode; dispid 30;
    property parsed: WordBool readonly dispid 31;
    property namespaceURI: WideString readonly dispid 32;
    property prefix: WideString readonly dispid 33;
    property baseName: WideString readonly dispid 34;
    procedure transformNodeToObject(const stylesheet: IXMLDOMNode; outputObject: OleVariant); dispid 35;
  end;

  IXMLDOMNodeList = interface(IDispatch)
    ['{2933BF82-7B36-11D2-B20E-00C04F983E60}']
    function Get_item(index: Integer): IXMLDOMNode; safecall;
    function Get_length: Integer; safecall;
    function nextNode: IXMLDOMNode; safecall;
    procedure Reset; safecall;
    function Get__newEnum: IUnknown; safecall;
    property item[index: Integer]: IXMLDOMNode read Get_item; default;
    property length: Integer read Get_length;
    property _newEnum: IUnknown read Get__newEnum;
  end;

  IXMLDOMNodeListDisp = dispinterface
    ['{2933BF82-7B36-11D2-B20E-00C04F983E60}']
    property item[index: Integer]: IXMLDOMNode readonly dispid 0; default;
    property length: Integer readonly dispid 74;
    function nextNode: IXMLDOMNode; dispid 76;
    procedure Reset; dispid 77;
    property _newEnum: IUnknown readonly dispid -4;
  end;

  IXMLDOMNamedNodeMap = interface(IDispatch)
    ['{2933BF83-7B36-11D2-B20E-00C04F983E60}']
    function getNamedItem(const name: WideString): IXMLDOMNode; safecall;
    function setNamedItem(const newItem: IXMLDOMNode): IXMLDOMNode; safecall;
    function removeNamedItem(const name: WideString): IXMLDOMNode; safecall;
    function Get_item(index: Integer): IXMLDOMNode; safecall;
    function Get_length: Integer; safecall;
    function getQualifiedItem(const baseName: WideString; const namespaceURI: WideString): IXMLDOMNode; safecall;
    function removeQualifiedItem(const baseName: WideString; const namespaceURI: WideString): IXMLDOMNode; safecall;
    function nextNode: IXMLDOMNode; safecall;
    procedure Reset; safecall;
    function Get__newEnum: IUnknown; safecall;
    property item[index: Integer]: IXMLDOMNode read Get_item; default;
    property length: Integer read Get_length;
    property _newEnum: IUnknown read Get__newEnum;
  end;

  IXMLDOMNamedNodeMapDisp = dispinterface
    ['{2933BF83-7B36-11D2-B20E-00C04F983E60}']
    function getNamedItem(const name: WideString): IXMLDOMNode; dispid 83;
    function setNamedItem(const newItem: IXMLDOMNode): IXMLDOMNode; dispid 84;
    function removeNamedItem(const name: WideString): IXMLDOMNode; dispid 85;
    property item[index: Integer]: IXMLDOMNode readonly dispid 0; default;
    property length: Integer readonly dispid 74;
    function getQualifiedItem(const baseName: WideString; const namespaceURI: WideString): IXMLDOMNode; dispid 87;
    function removeQualifiedItem(const baseName: WideString; const namespaceURI: WideString): IXMLDOMNode; dispid 88;
    function nextNode: IXMLDOMNode; dispid 89;
    procedure Reset; dispid 90;
    property _newEnum: IUnknown readonly dispid -4;
  end;

  IXMLDOMDocumentType = interface(IXMLDOMNode)
    ['{2933BF8B-7B36-11D2-B20E-00C04F983E60}']
    function Get_name: WideString; safecall;
    function Get_entities: IXMLDOMNamedNodeMap; safecall;
    function Get_notations: IXMLDOMNamedNodeMap; safecall;
    property name: WideString read Get_name;
    property entities: IXMLDOMNamedNodeMap read Get_entities;
    property notations: IXMLDOMNamedNodeMap read Get_notations;
  end;

  IXMLDOMDocumentTypeDisp = dispinterface
    ['{2933BF8B-7B36-11D2-B20E-00C04F983E60}']
    property name: WideString readonly dispid 131;
    property entities: IXMLDOMNamedNodeMap readonly dispid 132;
    property notations: IXMLDOMNamedNodeMap readonly dispid 133;
    property nodeName: WideString readonly dispid 2;
    property nodeValue: OleVariant dispid 3;
    property nodeType: DOMNodeType readonly dispid 4;
    property parentNode: IXMLDOMNode readonly dispid 6;
    property childNodes: {??PPUserType16}OleVariant readonly dispid 7;
    property firstChild: IXMLDOMNode readonly dispid 8;
    property lastChild: IXMLDOMNode readonly dispid 9;
    property previousSibling: IXMLDOMNode readonly dispid 10;
    property nextSibling: IXMLDOMNode readonly dispid 11;
    property attributes: {??PPUserType17}OleVariant readonly dispid 12;
    function insertBefore(const newChild: IXMLDOMNode; refChild: OleVariant): IXMLDOMNode; dispid 13;
    function replaceChild(const newChild: IXMLDOMNode; const oldChild: IXMLDOMNode): IXMLDOMNode; dispid 14;
    function removeChild(const childNode: IXMLDOMNode): IXMLDOMNode; dispid 15;
    function appendChild(const newChild: IXMLDOMNode): IXMLDOMNode; dispid 16;
    function hasChildNodes: WordBool; dispid 17;
    property ownerDocument: {??PPUserType18}OleVariant readonly dispid 18;
    function cloneNode(deep: WordBool): IXMLDOMNode; dispid 19;
    property nodeTypeString: WideString readonly dispid 21;
    property text: WideString dispid 24;
    property specified: WordBool readonly dispid 22;
    property definition: IXMLDOMNode readonly dispid 23;
    property nodeTypedValue: OleVariant dispid 25;
    function dataType: OleVariant; dispid 26;
    property xml: WideString readonly dispid 27;
    function transformNode(const stylesheet: IXMLDOMNode): WideString; dispid 28;
    function selectNodes(const queryString: WideString): IXMLDOMNodeList; dispid 29;
    function selectSingleNode(const queryString: WideString): IXMLDOMNode; dispid 30;
    property parsed: WordBool readonly dispid 31;
    property namespaceURI: WideString readonly dispid 32;
    property prefix: WideString readonly dispid 33;
    property baseName: WideString readonly dispid 34;
    procedure transformNodeToObject(const stylesheet: IXMLDOMNode; outputObject: OleVariant); dispid 35;
  end;

  IXMLDOMImplementation = interface(IDispatch)
    ['{2933BF8F-7B36-11D2-B20E-00C04F983E60}']
    function hasFeature(const feature: WideString; const version: WideString): WordBool; safecall;
  end;

  IXMLDOMImplementationDisp = dispinterface
    ['{2933BF8F-7B36-11D2-B20E-00C04F983E60}']
    function hasFeature(const feature: WideString; const version: WideString): WordBool; dispid 145;
  end;

  IXMLDOMElement = interface(IXMLDOMNode)
    ['{2933BF86-7B36-11D2-B20E-00C04F983E60}']
    function Get_tagName: WideString; safecall;
    function getAttribute(const name: WideString): OleVariant; safecall;
    procedure setAttribute(const name: WideString; value: OleVariant); safecall;
    procedure removeAttribute(const name: WideString); safecall;
    function getAttributeNode(const name: WideString): IXMLDOMAttribute; safecall;
    function setAttributeNode(const DOMAttribute: IXMLDOMAttribute): IXMLDOMAttribute; safecall;
    function removeAttributeNode(const DOMAttribute: IXMLDOMAttribute): IXMLDOMAttribute; safecall;
    function getElementsByTagName(const tagName: WideString): IXMLDOMNodeList; safecall;
    procedure normalize; safecall;
    property tagName: WideString read Get_tagName;
  end;

  IXMLDOMElementDisp = dispinterface
    ['{2933BF86-7B36-11D2-B20E-00C04F983E60}']
    property tagName: WideString readonly dispid 97;
    function getAttribute(const name: WideString): OleVariant; dispid 99;
    procedure setAttribute(const name: WideString; value: OleVariant); dispid 100;
    procedure removeAttribute(const name: WideString); dispid 101;
    function getAttributeNode(const name: WideString): IXMLDOMAttribute; dispid 102;
    function setAttributeNode(const DOMAttribute: IXMLDOMAttribute): IXMLDOMAttribute; dispid 103;
    function removeAttributeNode(const DOMAttribute: IXMLDOMAttribute): IXMLDOMAttribute; dispid 104;
    function getElementsByTagName(const tagName: WideString): IXMLDOMNodeList; dispid 105;
    procedure normalize; dispid 106;
    property nodeName: WideString readonly dispid 2;
    property nodeValue: OleVariant dispid 3;
    property nodeType: DOMNodeType readonly dispid 4;
    property parentNode: IXMLDOMNode readonly dispid 6;
    property childNodes: {??PPUserType16}OleVariant readonly dispid 7;
    property firstChild: IXMLDOMNode readonly dispid 8;
    property lastChild: IXMLDOMNode readonly dispid 9;
    property previousSibling: IXMLDOMNode readonly dispid 10;
    property nextSibling: IXMLDOMNode readonly dispid 11;
    property attributes: {??PPUserType17}OleVariant readonly dispid 12;
    function insertBefore(const newChild: IXMLDOMNode; refChild: OleVariant): IXMLDOMNode; dispid 13;
    function replaceChild(const newChild: IXMLDOMNode; const oldChild: IXMLDOMNode): IXMLDOMNode; dispid 14;
    function removeChild(const childNode: IXMLDOMNode): IXMLDOMNode; dispid 15;
    function appendChild(const newChild: IXMLDOMNode): IXMLDOMNode; dispid 16;
    function hasChildNodes: WordBool; dispid 17;
    property ownerDocument: {??PPUserType18}OleVariant readonly dispid 18;
    function cloneNode(deep: WordBool): IXMLDOMNode; dispid 19;
    property nodeTypeString: WideString readonly dispid 21;
    property text: WideString dispid 24;
    property specified: WordBool readonly dispid 22;
    property definition: IXMLDOMNode readonly dispid 23;
    property nodeTypedValue: OleVariant dispid 25;
    function dataType: OleVariant; dispid 26;
    property xml: WideString readonly dispid 27;
    function transformNode(const stylesheet: IXMLDOMNode): WideString; dispid 28;
    function selectNodes(const queryString: WideString): IXMLDOMNodeList; dispid 29;
    function selectSingleNode(const queryString: WideString): IXMLDOMNode; dispid 30;
    property parsed: WordBool readonly dispid 31;
    property namespaceURI: WideString readonly dispid 32;
    property prefix: WideString readonly dispid 33;
    property baseName: WideString readonly dispid 34;
    procedure transformNodeToObject(const stylesheet: IXMLDOMNode; outputObject: OleVariant); dispid 35;
  end;

  IXMLDOMAttribute = interface(IXMLDOMNode)
    ['{2933BF85-7B36-11D2-B20E-00C04F983E60}']
    function Get_name: WideString; safecall;
    function Get_value: OleVariant; safecall;
    procedure Set_value(attributeValue: OleVariant); safecall;
    property name: WideString read Get_name;
    property value: OleVariant read Get_value write Set_value;
  end;

  IXMLDOMAttributeDisp = dispinterface
    ['{2933BF85-7B36-11D2-B20E-00C04F983E60}']
    property name: WideString readonly dispid 118;
    property value: OleVariant dispid 120;
    property nodeName: WideString readonly dispid 2;
    property nodeValue: OleVariant dispid 3;
    property nodeType: DOMNodeType readonly dispid 4;
    property parentNode: IXMLDOMNode readonly dispid 6;
    property childNodes: {??PPUserType16}OleVariant readonly dispid 7;
    property firstChild: IXMLDOMNode readonly dispid 8;
    property lastChild: IXMLDOMNode readonly dispid 9;
    property previousSibling: IXMLDOMNode readonly dispid 10;
    property nextSibling: IXMLDOMNode readonly dispid 11;
    property attributes: {??PPUserType17}OleVariant readonly dispid 12;
    function insertBefore(const newChild: IXMLDOMNode; refChild: OleVariant): IXMLDOMNode; dispid 13;
    function replaceChild(const newChild: IXMLDOMNode; const oldChild: IXMLDOMNode): IXMLDOMNode; dispid 14;
    function removeChild(const childNode: IXMLDOMNode): IXMLDOMNode; dispid 15;
    function appendChild(const newChild: IXMLDOMNode): IXMLDOMNode; dispid 16;
    function hasChildNodes: WordBool; dispid 17;
    property ownerDocument: {??PPUserType18}OleVariant readonly dispid 18;
    function cloneNode(deep: WordBool): IXMLDOMNode; dispid 19;
    property nodeTypeString: WideString readonly dispid 21;
    property text: WideString dispid 24;
    property specified: WordBool readonly dispid 22;
    property definition: IXMLDOMNode readonly dispid 23;
    property nodeTypedValue: OleVariant dispid 25;
    function dataType: OleVariant; dispid 26;
    property xml: WideString readonly dispid 27;
    function transformNode(const stylesheet: IXMLDOMNode): WideString; dispid 28;
    function selectNodes(const queryString: WideString): IXMLDOMNodeList; dispid 29;
    function selectSingleNode(const queryString: WideString): IXMLDOMNode; dispid 30;
    property parsed: WordBool readonly dispid 31;
    property namespaceURI: WideString readonly dispid 32;
    property prefix: WideString readonly dispid 33;
    property baseName: WideString readonly dispid 34;
    procedure transformNodeToObject(const stylesheet: IXMLDOMNode; outputObject: OleVariant); dispid 35;
  end;

  IXMLDOMDocumentFragment = interface(IXMLDOMNode)
    ['{3EFAA413-272F-11D2-836F-0000F87A7782}']
  end;

  IXMLDOMDocumentFragmentDisp = dispinterface
    ['{3EFAA413-272F-11D2-836F-0000F87A7782}']
    property nodeName: WideString readonly dispid 2;
    property nodeValue: OleVariant dispid 3;
    property nodeType: DOMNodeType readonly dispid 4;
    property parentNode: IXMLDOMNode readonly dispid 6;
    property childNodes: {??PPUserType16}OleVariant readonly dispid 7;
    property firstChild: IXMLDOMNode readonly dispid 8;
    property lastChild: IXMLDOMNode readonly dispid 9;
    property previousSibling: IXMLDOMNode readonly dispid 10;
    property nextSibling: IXMLDOMNode readonly dispid 11;
    property attributes: {??PPUserType17}OleVariant readonly dispid 12;
    function insertBefore(const newChild: IXMLDOMNode; refChild: OleVariant): IXMLDOMNode; dispid 13;
    function replaceChild(const newChild: IXMLDOMNode; const oldChild: IXMLDOMNode): IXMLDOMNode; dispid 14;
    function removeChild(const childNode: IXMLDOMNode): IXMLDOMNode; dispid 15;
    function appendChild(const newChild: IXMLDOMNode): IXMLDOMNode; dispid 16;
    function hasChildNodes: WordBool; dispid 17;
    property ownerDocument: {??PPUserType18}OleVariant readonly dispid 18;
    function cloneNode(deep: WordBool): IXMLDOMNode; dispid 19;
    property nodeTypeString: WideString readonly dispid 21;
    property text: WideString dispid 24;
    property specified: WordBool readonly dispid 22;
    property definition: IXMLDOMNode readonly dispid 23;
    property nodeTypedValue: OleVariant dispid 25;
    function dataType: OleVariant; dispid 26;
    property xml: WideString readonly dispid 27;
    function transformNode(const stylesheet: IXMLDOMNode): WideString; dispid 28;
    function selectNodes(const queryString: WideString): IXMLDOMNodeList; dispid 29;
    function selectSingleNode(const queryString: WideString): IXMLDOMNode; dispid 30;
    property parsed: WordBool readonly dispid 31;
    property namespaceURI: WideString readonly dispid 32;
    property prefix: WideString readonly dispid 33;
    property baseName: WideString readonly dispid 34;
    procedure transformNodeToObject(const stylesheet: IXMLDOMNode; outputObject: OleVariant); dispid 35;
  end;

  IXMLDOMCharacterData = interface(IXMLDOMNode)
    ['{2933BF84-7B36-11D2-B20E-00C04F983E60}']
    function Get_data: WideString; safecall;
    procedure Set_data(const data: WideString); safecall;
    function Get_length: Integer; safecall;
    function substringData(offset: Integer; count: Integer): WideString; safecall;
    procedure appendData(const data: WideString); safecall;
    procedure insertData(offset: Integer; const data: WideString); safecall;
    procedure deleteData(offset: Integer; count: Integer); safecall;
    procedure replaceData(offset: Integer; count: Integer; const data: WideString); safecall;
    property data: WideString read Get_data write Set_data;
    property length: Integer read Get_length;
  end;

  IXMLDOMCharacterDataDisp = dispinterface
    ['{2933BF84-7B36-11D2-B20E-00C04F983E60}']
    property data: WideString dispid 109;
    property length: Integer readonly dispid 110;
    function substringData(offset: Integer; count: Integer): WideString; dispid 111;
    procedure appendData(const data: WideString); dispid 112;
    procedure insertData(offset: Integer; const data: WideString); dispid 113;
    procedure deleteData(offset: Integer; count: Integer); dispid 114;
    procedure replaceData(offset: Integer; count: Integer; const data: WideString); dispid 115;
    property nodeName: WideString readonly dispid 2;
    property nodeValue: OleVariant dispid 3;
    property nodeType: DOMNodeType readonly dispid 4;
    property parentNode: IXMLDOMNode readonly dispid 6;
    property childNodes: {??PPUserType16}OleVariant readonly dispid 7;
    property firstChild: IXMLDOMNode readonly dispid 8;
    property lastChild: IXMLDOMNode readonly dispid 9;
    property previousSibling: IXMLDOMNode readonly dispid 10;
    property nextSibling: IXMLDOMNode readonly dispid 11;
    property attributes: {??PPUserType17}OleVariant readonly dispid 12;
    function insertBefore(const newChild: IXMLDOMNode; refChild: OleVariant): IXMLDOMNode; dispid 13;
    function replaceChild(const newChild: IXMLDOMNode; const oldChild: IXMLDOMNode): IXMLDOMNode; dispid 14;
    function removeChild(const childNode: IXMLDOMNode): IXMLDOMNode; dispid 15;
    function appendChild(const newChild: IXMLDOMNode): IXMLDOMNode; dispid 16;
    function hasChildNodes: WordBool; dispid 17;
    property ownerDocument: {??PPUserType18}OleVariant readonly dispid 18;
    function cloneNode(deep: WordBool): IXMLDOMNode; dispid 19;
    property nodeTypeString: WideString readonly dispid 21;
    property text: WideString dispid 24;
    property specified: WordBool readonly dispid 22;
    property definition: IXMLDOMNode readonly dispid 23;
    property nodeTypedValue: OleVariant dispid 25;
    function dataType: OleVariant; dispid 26;
    property xml: WideString readonly dispid 27;
    function transformNode(const stylesheet: IXMLDOMNode): WideString; dispid 28;
    function selectNodes(const queryString: WideString): IXMLDOMNodeList; dispid 29;
    function selectSingleNode(const queryString: WideString): IXMLDOMNode; dispid 30;
    property parsed: WordBool readonly dispid 31;
    property namespaceURI: WideString readonly dispid 32;
    property prefix: WideString readonly dispid 33;
    property baseName: WideString readonly dispid 34;
    procedure transformNodeToObject(const stylesheet: IXMLDOMNode; outputObject: OleVariant); dispid 35;
  end;

  IXMLDOMText = interface(IXMLDOMCharacterData)
    ['{2933BF87-7B36-11D2-B20E-00C04F983E60}']
    function splitText(offset: Integer): IXMLDOMText; safecall;
  end;

  IXMLDOMTextDisp = dispinterface
    ['{2933BF87-7B36-11D2-B20E-00C04F983E60}']
    function splitText(offset: Integer): IXMLDOMText; dispid 123;
    property data: WideString dispid 109;
    property length: Integer readonly dispid 110;
    function substringData(offset: Integer; count: Integer): WideString; dispid 111;
    procedure appendData(const data: WideString); dispid 112;
    procedure insertData(offset: Integer; const data: WideString); dispid 113;
    procedure deleteData(offset: Integer; count: Integer); dispid 114;
    procedure replaceData(offset: Integer; count: Integer; const data: WideString); dispid 115;
    property nodeName: WideString readonly dispid 2;
    property nodeValue: OleVariant dispid 3;
    property nodeType: DOMNodeType readonly dispid 4;
    property parentNode: IXMLDOMNode readonly dispid 6;
    property childNodes: {??PPUserType16}OleVariant readonly dispid 7;
    property firstChild: IXMLDOMNode readonly dispid 8;
    property lastChild: IXMLDOMNode readonly dispid 9;
    property previousSibling: IXMLDOMNode readonly dispid 10;
    property nextSibling: IXMLDOMNode readonly dispid 11;
    property attributes: {??PPUserType17}OleVariant readonly dispid 12;
    function insertBefore(const newChild: IXMLDOMNode; refChild: OleVariant): IXMLDOMNode; dispid 13;
    function replaceChild(const newChild: IXMLDOMNode; const oldChild: IXMLDOMNode): IXMLDOMNode; dispid 14;
    function removeChild(const childNode: IXMLDOMNode): IXMLDOMNode; dispid 15;
    function appendChild(const newChild: IXMLDOMNode): IXMLDOMNode; dispid 16;
    function hasChildNodes: WordBool; dispid 17;
    property ownerDocument: {??PPUserType18}OleVariant readonly dispid 18;
    function cloneNode(deep: WordBool): IXMLDOMNode; dispid 19;
    property nodeTypeString: WideString readonly dispid 21;
    property text: WideString dispid 24;
    property specified: WordBool readonly dispid 22;
    property definition: IXMLDOMNode readonly dispid 23;
    property nodeTypedValue: OleVariant dispid 25;
    function dataType: OleVariant; dispid 26;
    property xml: WideString readonly dispid 27;
    function transformNode(const stylesheet: IXMLDOMNode): WideString; dispid 28;
    function selectNodes(const queryString: WideString): IXMLDOMNodeList; dispid 29;
    function selectSingleNode(const queryString: WideString): IXMLDOMNode; dispid 30;
    property parsed: WordBool readonly dispid 31;
    property namespaceURI: WideString readonly dispid 32;
    property prefix: WideString readonly dispid 33;
    property baseName: WideString readonly dispid 34;
    procedure transformNodeToObject(const stylesheet: IXMLDOMNode; outputObject: OleVariant); dispid 35;
  end;

  IXMLDOMComment = interface(IXMLDOMCharacterData)
    ['{2933BF88-7B36-11D2-B20E-00C04F983E60}']
  end;

  IXMLDOMCommentDisp = dispinterface
    ['{2933BF88-7B36-11D2-B20E-00C04F983E60}']
    property data: WideString dispid 109;
    property length: Integer readonly dispid 110;
    function substringData(offset: Integer; count: Integer): WideString; dispid 111;
    procedure appendData(const data: WideString); dispid 112;
    procedure insertData(offset: Integer; const data: WideString); dispid 113;
    procedure deleteData(offset: Integer; count: Integer); dispid 114;
    procedure replaceData(offset: Integer; count: Integer; const data: WideString); dispid 115;
    property nodeName: WideString readonly dispid 2;
    property nodeValue: OleVariant dispid 3;
    property nodeType: DOMNodeType readonly dispid 4;
    property parentNode: IXMLDOMNode readonly dispid 6;
    property childNodes: {??PPUserType16}OleVariant readonly dispid 7;
    property firstChild: IXMLDOMNode readonly dispid 8;
    property lastChild: IXMLDOMNode readonly dispid 9;
    property previousSibling: IXMLDOMNode readonly dispid 10;
    property nextSibling: IXMLDOMNode readonly dispid 11;
    property attributes: {??PPUserType17}OleVariant readonly dispid 12;
    function insertBefore(const newChild: IXMLDOMNode; refChild: OleVariant): IXMLDOMNode; dispid 13;
    function replaceChild(const newChild: IXMLDOMNode; const oldChild: IXMLDOMNode): IXMLDOMNode; dispid 14;
    function removeChild(const childNode: IXMLDOMNode): IXMLDOMNode; dispid 15;
    function appendChild(const newChild: IXMLDOMNode): IXMLDOMNode; dispid 16;
    function hasChildNodes: WordBool; dispid 17;
    property ownerDocument: {??PPUserType18}OleVariant readonly dispid 18;
    function cloneNode(deep: WordBool): IXMLDOMNode; dispid 19;
    property nodeTypeString: WideString readonly dispid 21;
    property text: WideString dispid 24;
    property specified: WordBool readonly dispid 22;
    property definition: IXMLDOMNode readonly dispid 23;
    property nodeTypedValue: OleVariant dispid 25;
    function dataType: OleVariant; dispid 26;
    property xml: WideString readonly dispid 27;
    function transformNode(const stylesheet: IXMLDOMNode): WideString; dispid 28;
    function selectNodes(const queryString: WideString): IXMLDOMNodeList; dispid 29;
    function selectSingleNode(const queryString: WideString): IXMLDOMNode; dispid 30;
    property parsed: WordBool readonly dispid 31;
    property namespaceURI: WideString readonly dispid 32;
    property prefix: WideString readonly dispid 33;
    property baseName: WideString readonly dispid 34;
    procedure transformNodeToObject(const stylesheet: IXMLDOMNode; outputObject: OleVariant); dispid 35;
  end;

  IXMLDOMCDATASection = interface(IXMLDOMText)
    ['{2933BF8A-7B36-11D2-B20E-00C04F983E60}']
  end;

  IXMLDOMCDATASectionDisp = dispinterface
    ['{2933BF8A-7B36-11D2-B20E-00C04F983E60}']
    function splitText(offset: Integer): IXMLDOMText; dispid 123;
    property data: WideString dispid 109;
    property length: Integer readonly dispid 110;
    function substringData(offset: Integer; count: Integer): WideString; dispid 111;
    procedure appendData(const data: WideString); dispid 112;
    procedure insertData(offset: Integer; const data: WideString); dispid 113;
    procedure deleteData(offset: Integer; count: Integer); dispid 114;
    procedure replaceData(offset: Integer; count: Integer; const data: WideString); dispid 115;
    property nodeName: WideString readonly dispid 2;
    property nodeValue: OleVariant dispid 3;
    property nodeType: DOMNodeType readonly dispid 4;
    property parentNode: IXMLDOMNode readonly dispid 6;
    property childNodes: {??PPUserType16}OleVariant readonly dispid 7;
    property firstChild: IXMLDOMNode readonly dispid 8;
    property lastChild: IXMLDOMNode readonly dispid 9;
    property previousSibling: IXMLDOMNode readonly dispid 10;
    property nextSibling: IXMLDOMNode readonly dispid 11;
    property attributes: {??PPUserType17}OleVariant readonly dispid 12;
    function insertBefore(const newChild: IXMLDOMNode; refChild: OleVariant): IXMLDOMNode; dispid 13;
    function replaceChild(const newChild: IXMLDOMNode; const oldChild: IXMLDOMNode): IXMLDOMNode; dispid 14;
    function removeChild(const childNode: IXMLDOMNode): IXMLDOMNode; dispid 15;
    function appendChild(const newChild: IXMLDOMNode): IXMLDOMNode; dispid 16;
    function hasChildNodes: WordBool; dispid 17;
    property ownerDocument: {??PPUserType18}OleVariant readonly dispid 18;
    function cloneNode(deep: WordBool): IXMLDOMNode; dispid 19;
    property nodeTypeString: WideString readonly dispid 21;
    property text: WideString dispid 24;
    property specified: WordBool readonly dispid 22;
    property definition: IXMLDOMNode readonly dispid 23;
    property nodeTypedValue: OleVariant dispid 25;
    function dataType: OleVariant; dispid 26;
    property xml: WideString readonly dispid 27;
    function transformNode(const stylesheet: IXMLDOMNode): WideString; dispid 28;
    function selectNodes(const queryString: WideString): IXMLDOMNodeList; dispid 29;
    function selectSingleNode(const queryString: WideString): IXMLDOMNode; dispid 30;
    property parsed: WordBool readonly dispid 31;
    property namespaceURI: WideString readonly dispid 32;
    property prefix: WideString readonly dispid 33;
    property baseName: WideString readonly dispid 34;
    procedure transformNodeToObject(const stylesheet: IXMLDOMNode; outputObject: OleVariant); dispid 35;
  end;

  IXMLDOMProcessingInstruction = interface(IXMLDOMNode)
    ['{2933BF89-7B36-11D2-B20E-00C04F983E60}']
    function Get_target: WideString; safecall;
    function Get_data: WideString; safecall;
    procedure Set_data(const value: WideString); safecall;
    property target: WideString read Get_target;
    property data: WideString read Get_data write Set_data;
  end;

  IXMLDOMProcessingInstructionDisp = dispinterface
    ['{2933BF89-7B36-11D2-B20E-00C04F983E60}']
    property target: WideString readonly dispid 127;
    property data: WideString dispid 128;
    property nodeName: WideString readonly dispid 2;
    property nodeValue: OleVariant dispid 3;
    property nodeType: DOMNodeType readonly dispid 4;
    property parentNode: IXMLDOMNode readonly dispid 6;
    property childNodes: {??PPUserType16}OleVariant readonly dispid 7;
    property firstChild: IXMLDOMNode readonly dispid 8;
    property lastChild: IXMLDOMNode readonly dispid 9;
    property previousSibling: IXMLDOMNode readonly dispid 10;
    property nextSibling: IXMLDOMNode readonly dispid 11;
    property attributes: {??PPUserType17}OleVariant readonly dispid 12;
    function insertBefore(const newChild: IXMLDOMNode; refChild: OleVariant): IXMLDOMNode; dispid 13;
    function replaceChild(const newChild: IXMLDOMNode; const oldChild: IXMLDOMNode): IXMLDOMNode; dispid 14;
    function removeChild(const childNode: IXMLDOMNode): IXMLDOMNode; dispid 15;
    function appendChild(const newChild: IXMLDOMNode): IXMLDOMNode; dispid 16;
    function hasChildNodes: WordBool; dispid 17;
    property ownerDocument: {??PPUserType18}OleVariant readonly dispid 18;
    function cloneNode(deep: WordBool): IXMLDOMNode; dispid 19;
    property nodeTypeString: WideString readonly dispid 21;
    property text: WideString dispid 24;
    property specified: WordBool readonly dispid 22;
    property definition: IXMLDOMNode readonly dispid 23;
    property nodeTypedValue: OleVariant dispid 25;
    function dataType: OleVariant; dispid 26;
    property xml: WideString readonly dispid 27;
    function transformNode(const stylesheet: IXMLDOMNode): WideString; dispid 28;
    function selectNodes(const queryString: WideString): IXMLDOMNodeList; dispid 29;
    function selectSingleNode(const queryString: WideString): IXMLDOMNode; dispid 30;
    property parsed: WordBool readonly dispid 31;
    property namespaceURI: WideString readonly dispid 32;
    property prefix: WideString readonly dispid 33;
    property baseName: WideString readonly dispid 34;
    procedure transformNodeToObject(const stylesheet: IXMLDOMNode; outputObject: OleVariant); dispid 35;
  end;

  IXMLDOMEntityReference = interface(IXMLDOMNode)
    ['{2933BF8E-7B36-11D2-B20E-00C04F983E60}']
  end;

  IXMLDOMEntityReferenceDisp = dispinterface
    ['{2933BF8E-7B36-11D2-B20E-00C04F983E60}']
    property nodeName: WideString readonly dispid 2;
    property nodeValue: OleVariant dispid 3;
    property nodeType: DOMNodeType readonly dispid 4;
    property parentNode: IXMLDOMNode readonly dispid 6;
    property childNodes: {??PPUserType16}OleVariant readonly dispid 7;
    property firstChild: IXMLDOMNode readonly dispid 8;
    property lastChild: IXMLDOMNode readonly dispid 9;
    property previousSibling: IXMLDOMNode readonly dispid 10;
    property nextSibling: IXMLDOMNode readonly dispid 11;
    property attributes: {??PPUserType17}OleVariant readonly dispid 12;
    function insertBefore(const newChild: IXMLDOMNode; refChild: OleVariant): IXMLDOMNode; dispid 13;
    function replaceChild(const newChild: IXMLDOMNode; const oldChild: IXMLDOMNode): IXMLDOMNode; dispid 14;
    function removeChild(const childNode: IXMLDOMNode): IXMLDOMNode; dispid 15;
    function appendChild(const newChild: IXMLDOMNode): IXMLDOMNode; dispid 16;
    function hasChildNodes: WordBool; dispid 17;
    property ownerDocument: {??PPUserType18}OleVariant readonly dispid 18;
    function cloneNode(deep: WordBool): IXMLDOMNode; dispid 19;
    property nodeTypeString: WideString readonly dispid 21;
    property text: WideString dispid 24;
    property specified: WordBool readonly dispid 22;
    property definition: IXMLDOMNode readonly dispid 23;
    property nodeTypedValue: OleVariant dispid 25;
    function dataType: OleVariant; dispid 26;
    property xml: WideString readonly dispid 27;
    function transformNode(const stylesheet: IXMLDOMNode): WideString; dispid 28;
    function selectNodes(const queryString: WideString): IXMLDOMNodeList; dispid 29;
    function selectSingleNode(const queryString: WideString): IXMLDOMNode; dispid 30;
    property parsed: WordBool readonly dispid 31;
    property namespaceURI: WideString readonly dispid 32;
    property prefix: WideString readonly dispid 33;
    property baseName: WideString readonly dispid 34;
    procedure transformNodeToObject(const stylesheet: IXMLDOMNode; outputObject: OleVariant); dispid 35;
  end;

  IXMLDOMParseError = interface(IDispatch)
    ['{3EFAA426-272F-11D2-836F-0000F87A7782}']
    function Get_errorCode: Integer; safecall;
    function Get_url: WideString; safecall;
    function Get_reason: WideString; safecall;
    function Get_srcText: WideString; safecall;
    function Get_line: Integer; safecall;
    function Get_linepos: Integer; safecall;
    function Get_filepos: Integer; safecall;
    property errorCode: Integer read Get_errorCode;
    property url: WideString read Get_url;
    property reason: WideString read Get_reason;
    property srcText: WideString read Get_srcText;
    property line: Integer read Get_line;
    property linepos: Integer read Get_linepos;
    property filepos: Integer read Get_filepos;
  end;

  IXMLDOMParseErrorDisp = dispinterface
    ['{3EFAA426-272F-11D2-836F-0000F87A7782}']
    property errorCode: Integer readonly dispid 0;
    property url: WideString readonly dispid 179;
    property reason: WideString readonly dispid 180;
    property srcText: WideString readonly dispid 181;
    property line: Integer readonly dispid 182;
    property linepos: Integer readonly dispid 183;
    property filepos: Integer readonly dispid 184;
  end;

  IFolderViewHost = interface(IUnknown)
    ['{1EA58F02-D55A-411D-B09E-9E65AC21605B}']
    function Initialize(var hwndParent: _RemotableHandle; const pdo: IDataObject; var prc: tagRECT): HResult; stdcall;
  end;

  IExplorerBrowser = interface(IUnknown)
    ['{DFD3B6B5-C10C-4BE9-85F6-A66969F402F6}']
    function Initialize(var hwndParent: _RemotableHandle; var prc: tagRECT; var pfs: FOLDERSETTINGS): HResult; stdcall;
    function Destroy: HResult; stdcall;
    function SetRect(var phdwp: Pointer; rcBrowser: tagRECT): HResult; stdcall;
    function SetPropertyBag(pszPropertyBag: PWideChar): HResult; stdcall;
    function SetEmptyText(pszEmptyText: PWideChar): HResult; stdcall;
    function SetFolderSettings(var pfs: FOLDERSETTINGS): HResult; stdcall;
    function Advise(const psbe: IExplorerBrowserEvents; out pdwCookie: LongWord): HResult; stdcall;
    function Unadvise(dwCookie: LongWord): HResult; stdcall;
    function SetOptions(dwFlag: EXPLORER_BROWSER_OPTIONS): HResult; stdcall;
    function GetOptions(out pdwFlag: EXPLORER_BROWSER_OPTIONS): HResult; stdcall;
    function BrowseToIDList(var pidl: _BYTE_BLOB; uFlags: SYSUINT): HResult; stdcall;
    function BrowseToObject(const punk: IUnknown; uFlags: SYSUINT): HResult; stdcall;
    function FillFromObject(const punk: IUnknown; dwFlags: EXPLORER_BROWSER_FILL_FLAGS): HResult; stdcall;
    function RemoveAll: HResult; stdcall;
    function GetCurrentView(var riid: TGUID; out ppv: Pointer): HResult; stdcall;
  end;

  IExplorerBrowserEvents = interface(IUnknown)
    ['{361BBDC7-E6EE-4E13-BE58-58E2240C810F}']
    function OnNavigationPending(var pidlFolder: _BYTE_BLOB): HResult; stdcall;
    function OnViewCreated(const psv: IShellView): HResult; stdcall;
    function OnNavigationComplete(var pidlFolder: _BYTE_BLOB): HResult; stdcall;
    function OnNavigationFailed(var pidlFolder: _BYTE_BLOB): HResult; stdcall;
  end;

  IOleWindow = interface(IUnknown)
    ['{00000114-0000-0000-C000-000000000046}']
    function GetWindow(out phwnd: wireHWND): HResult; stdcall;
    function ContextSensitiveHelp(fEnterMode: Integer): HResult; stdcall;
  end;

  IShellView = interface(IOleWindow)
    ['{000214E3-0000-0000-C000-000000000046}']
    function TranslateAccelerator(var pmsg: tagMSG): HResult; stdcall;
    function EnableModeless(fEnable: Integer): HResult; stdcall;
    function UIActivate(uState: SYSUINT): HResult; stdcall;
    function Refresh: HResult; stdcall;
    function CreateViewWindow(const psvPrevious: IShellView; var pfs: FOLDERSETTINGS; 
                              const psb: IShellBrowser; var prcView: tagRECT; out phwnd: wireHWND): HResult; stdcall;
    function DestroyViewWindow: HResult; stdcall;
    function GetCurrentInfo(out pfs: FOLDERSETTINGS): HResult; stdcall;
    function AddPropertySheetPages(dwReserved: LongWord; pfn: LONG_PTR; lParam: LONG_PTR): HResult; stdcall;
    function SaveViewState: HResult; stdcall;
    function SelectItem(var pidlItem: _BYTE_BLOB; uFlags: SYSUINT): HResult; stdcall;
    function GetItemObject(uItem: SYSUINT; var riid: TGUID; out ppv: Pointer): HResult; stdcall;
  end;

  IShellBrowser = interface(IOleWindow)
    ['{000214E2-0000-0000-C000-000000000046}']
    function InsertMenusSB(var hmenuShared: _RemotableHandle; 
                           var lpMenuWidths: tagOleMenuGroupWidths): HResult; stdcall;
    function SetMenuSB(var hmenuShared: _RemotableHandle; var holemenuRes: _userHGLOBAL; 
                       var hwndActiveObject: _RemotableHandle): HResult; stdcall;
    function RemoveMenusSB(var hmenuShared: _RemotableHandle): HResult; stdcall;
    function SetStatusTextSB(pszStatusText: PWideChar): HResult; stdcall;
    function EnableModelessSB(fEnable: Integer): HResult; stdcall;
    function TranslateAcceleratorSB(var pmsg: tagMSG; wID: Word): HResult; stdcall;
    function BrowseObject(var pidl: _BYTE_BLOB; wFlags: SYSUINT): HResult; stdcall;
    function GetViewStateStream(grfMode: LongWord; out ppStrm: IStream): HResult; stdcall;
    function GetControlWindow(id: SYSUINT; out phwnd: wireHWND): HResult; stdcall;
    function SendControlMsg(id: SYSUINT; uMsg: SYSUINT; wParam: UINT_PTR; lParam: LONG_PTR; 
                            out pret: LONG_PTR): HResult; stdcall;
    function QueryActiveShellView(out ppshv: IShellView): HResult; stdcall;
    function OnViewWindowActive(const pshv: IShellView): HResult; stdcall;
    function SetToolbarItems(lpButtons: LONG_PTR; nButtons: SYSUINT; uFlags: SYSUINT): HResult; stdcall;
  end;

  IImageRecompress = interface(IUnknown)
    ['{505F1513-6B3E-4892-A272-59F8889A4D3E}']
    function RecompressImage(const psi: IShellItem; cx: SYSINT; cy: SYSINT; iQuality: SYSINT; 
                             const pstg: IStorage; out ppstrmOut: IStream): HResult; stdcall;
  end;

  IBandSite = interface(IUnknown)
    ['{4CF504B0-DE96-11D0-8B3F-00A0C911E8E5}']
    function AddBand(const punk: IUnknown): HResult; stdcall;
    function EnumBands(uBand: SYSUINT; out pdwBandID: LongWord): HResult; stdcall;
    function RemoteQueryBand(dwBandID: LongWord; out ppstb: IDeskBand; out pdwState: LongWord; 
                             pszName: PWideChar; cchName: SYSINT): HResult; stdcall;
    function SetBandState(dwBandID: LongWord; dwMask: LongWord; dwState: LongWord): HResult; stdcall;
    function RemoveBand(dwBandID: LongWord): HResult; stdcall;
    function GetBandObject(dwBandID: LongWord; var riid: TGUID; out ppv: Pointer): HResult; stdcall;
    function SetBandSiteInfo(var pbsinfo: tagBANDSITEINFO): HResult; stdcall;
    function GetBandSiteInfo(var pbsinfo: tagBANDSITEINFO): HResult; stdcall;
  end;

  IDockingWindow = interface(IOleWindow)
    ['{012DD920-7B26-11D0-8CA9-00A0C92DBFE8}']
    function ShowDW(fShow: Integer): HResult; stdcall;
    function CloseDW(dwReserved: LongWord): HResult; stdcall;
    function ResizeBorderDW(var prcBorder: tagRECT; const punkToolbarSite: IUnknown; 
                            fReserved: Integer): HResult; stdcall;
  end;

  IDeskBand = interface(IDockingWindow)
    ['{EB0FE172-1A3A-11D0-89B3-00A0C90A90AC}']
    function GetBandInfo(dwBandID: LongWord; dwViewMode: LongWord; var pdbi: DESKBANDINFO): HResult; stdcall;
  end;

  ITrayDeskBand = interface(IUnknown)
    ['{6D67E846-5B9C-4DB8-9CBC-DDE12F4254F1}']
    function ShowDeskBand(var clsid: TGUID): HResult; stdcall;
    function HideDeskBand(var clsid: TGUID): HResult; stdcall;
    function IsDeskBandShown(var clsid: TGUID): HResult; stdcall;
    function DeskBandRegistrationChanged: HResult; stdcall;
  end;

  IAttachmentExecute = interface(IUnknown)
    ['{73DB1241-1E85-4581-8E4F-A81E1D0F8C57}']
    function SetClientTitle(pszTitle: PWideChar): HResult; stdcall;
    function SetClientGuid(var guid: TGUID): HResult; stdcall;
    function SetLocalPath(pszLocalPath: PWideChar): HResult; stdcall;
    function SetFileName(pszFileName: PWideChar): HResult; stdcall;
    function SetSource(pszSource: PWideChar): HResult; stdcall;
    function SetReferrer(pszReferrer: PWideChar): HResult; stdcall;
    function CheckPolicy: HResult; stdcall;
    function Prompt(var hwnd: _RemotableHandle; Prompt: ATTACHMENT_PROMPT; 
                    out paction: ATTACHMENT_ACTION): HResult; stdcall;
    function Save: HResult; stdcall;
    function Execute(var hwnd: _RemotableHandle; pszVerb: PWideChar; out phProcess: Pointer): HResult; stdcall;
    function SaveWithUI(var hwnd: _RemotableHandle): HResult; stdcall;
    function ClearClientState: HResult; stdcall;
  end;

  IShellExtInit = interface(IUnknown)
    ['{000214E8-0000-0000-C000-000000000046}']
    function Initialize(var pidlFolder: _BYTE_BLOB; const pdtobj: IDataObject; 
                        var hkeyProgID: Pointer): HResult; stdcall;
  end;

  IShellItem2 = interface(IShellItem)
    ['{7E9FB0D3-919F-4307-AB2E-9B1860310C93}']
    function GetPropertyStore(Flags: GETPROPERTYSTOREFLAGS; var riid: TGUID; out ppv: Pointer): HResult; stdcall;
    function GetPropertyStoreWithCreateObject(Flags: GETPROPERTYSTOREFLAGS; 
                                              const punkCreateObject: IUnknown; var riid: TGUID; 
                                              out ppv: Pointer): HResult; stdcall;
    function GetPropertyStoreForKeys(var rgKeys: _tagpropertykey; cKeys: SYSUINT; 
                                     Flags: GETPROPERTYSTOREFLAGS; var riid: TGUID; out ppv: Pointer): HResult; stdcall;
    function GetPropertyDescriptionList(var keyType: _tagpropertykey; var riid: TGUID; 
                                        out ppv: Pointer): HResult; stdcall;
    function Update(const pbc: IBindCtx): HResult; stdcall;
    function GetProperty(var key: _tagpropertykey; out ppropvar: tag_inner_PROPVARIANT): HResult; stdcall;
    function GetCLSID(var key: _tagpropertykey; out pclsid: TGUID): HResult; stdcall;
    function GetFileTime(var key: _tagpropertykey; out pft: _FILETIME): HResult; stdcall;
    function GetInt32(var key: _tagpropertykey; out pi: SYSINT): HResult; stdcall;
    function GetString(var key: _tagpropertykey; out ppsz: PWideChar): HResult; stdcall;
    function GetUInt32(var key: _tagpropertykey; out pui: LongWord): HResult; stdcall;
    function GetUInt64(var key: _tagpropertykey; out pull: Largeuint): HResult; stdcall;
    function GetBool(var key: _tagpropertykey; out pf: Integer): HResult; stdcall;
  end;

  INamespaceWalk = interface(IUnknown)
    ['{57CED8A7-3F4A-432C-9350-30F24483F74F}']
    function Walk(const punkToWalk: IUnknown; dwFlags: LongWord; cDepth: SYSINT; 
                  const pnswcb: INamespaceWalkCB): HResult; stdcall;
    function GetIDArrayResult(out pcItems: SYSUINT; out prgpidl: PPUserType1): HResult; stdcall;
  end;

  INamespaceWalkCB = interface(IUnknown)
    ['{D92995F8-CF5E-4A76-BF59-EAD39EA2B97E}']
    function FoundItem(const psf: IShellFolder; var pidl: _BYTE_BLOB): HResult; stdcall;
    function EnterFolder(const psf: IShellFolder; var pidl: _BYTE_BLOB): HResult; stdcall;
    function LeaveFolder(const psf: IShellFolder; var pidl: _BYTE_BLOB): HResult; stdcall;
    function InitializeProgressDialog(out ppszTitle: PWideChar; out ppszCancel: PWideChar): HResult; stdcall;
  end;

  IFileOperation = interface(IUnknown)
    ['{947AAB5F-0A5C-4C13-B4D6-4BF7836FC9F8}']
    function Advise(const pfops: IFileOperationProgressSink; out pdwCookie: LongWord): HResult; stdcall;
    function Unadvise(dwCookie: LongWord): HResult; stdcall;
    function SetOperationFlags(dwOperationFlags: LongWord): HResult; stdcall;
    function SetProgressMessage(pszMessage: PWideChar): HResult; stdcall;
    function SetProgressDialog(const popd: IOperationsProgressDialog): HResult; stdcall;
    function SetProperties(const pproparray: IPropertyChangeArray): HResult; stdcall;
    function SetOwnerWindow(var hwndOwner: _RemotableHandle): HResult; stdcall;
    function ApplyPropertiesToItem(const psiItem: IShellItem): HResult; stdcall;
    function ApplyPropertiesToItems(const punkItems: IUnknown): HResult; stdcall;
    function RenameItem(const psiItem: IShellItem; pszNewName: PWideChar; 
                        const pfopsItem: IFileOperationProgressSink): HResult; stdcall;
    function RenameItems(const punkItems: IUnknown; pszNewName: PWideChar): HResult; stdcall;
    function MoveItem(const psiItem: IShellItem; const psiDestinationFolder: IShellItem; 
                      pszNewName: PWideChar; const pfopsItem: IFileOperationProgressSink): HResult; stdcall;
    function MoveItems(const punkItems: IUnknown; const psiDestinationFolder: IShellItem): HResult; stdcall;
    function CopyItem(const psiItem: IShellItem; const psiDestinationFolder: IShellItem; 
                      pszCopyName: PWideChar; const pfopsItem: IFileOperationProgressSink): HResult; stdcall;
    function CopyItems(const punkItems: IUnknown; const psiDestinationFolder: IShellItem): HResult; stdcall;
    function DeleteItem(const psiItem: IShellItem; const pfopsItem: IFileOperationProgressSink): HResult; stdcall;
    function DeleteItems(const punkItems: IUnknown): HResult; stdcall;
    function newItem(const psiDestinationFolder: IShellItem; dwFileAttributes: LongWord; 
                     pszName: PWideChar; pszTemplateName: PWideChar; 
                     const pfopsItem: IFileOperationProgressSink): HResult; stdcall;
    function PerformOperations: HResult; stdcall;
    function GetAnyOperationsAborted(out pfAnyOperationsAborted: Integer): HResult; stdcall;
  end;

  IFileOperationProgressSink = interface(IUnknown)
    ['{04B0F1A7-9490-44BC-96E1-4296A31252E2}']
    function StartOperations: HResult; stdcall;
    function FinishOperations(hrResult: HResult): HResult; stdcall;
    function PreRenameItem(dwFlags: LongWord; const psiItem: IShellItem; pszNewName: PWideChar): HResult; stdcall;
    function PostRenameItem(dwFlags: LongWord; const psiItem: IShellItem; pszNewName: PWideChar; 
                            hrRename: HResult; const psiNewlyCreated: IShellItem): HResult; stdcall;
    function PreMoveItem(dwFlags: LongWord; const psiItem: IShellItem; 
                         const psiDestinationFolder: IShellItem; pszNewName: PWideChar): HResult; stdcall;
    function PostMoveItem(dwFlags: LongWord; const psiItem: IShellItem; 
                          const psiDestinationFolder: IShellItem; pszNewName: PWideChar; 
                          hrMove: HResult; const psiNewlyCreated: IShellItem): HResult; stdcall;
    function PreCopyItem(dwFlags: LongWord; const psiItem: IShellItem; 
                         const psiDestinationFolder: IShellItem; pszNewName: PWideChar): HResult; stdcall;
    function PostCopyItem(dwFlags: LongWord; const psiItem: IShellItem; 
                          const psiDestinationFolder: IShellItem; pszNewName: PWideChar; 
                          hrCopy: HResult; const psiNewlyCreated: IShellItem): HResult; stdcall;
    function PreDeleteItem(dwFlags: LongWord; const psiItem: IShellItem): HResult; stdcall;
    function PostDeleteItem(dwFlags: LongWord; const psiItem: IShellItem; hrDelete: HResult; 
                            const psiNewlyCreated: IShellItem): HResult; stdcall;
    function PreNewItem(dwFlags: LongWord; const psiDestinationFolder: IShellItem; 
                        pszNewName: PWideChar): HResult; stdcall;
    function PostNewItem(dwFlags: LongWord; const psiDestinationFolder: IShellItem; 
                         pszNewName: PWideChar; pszTemplateName: PWideChar; 
                         dwFileAttributes: LongWord; hrNew: HResult; const psiNewItem: IShellItem): HResult; stdcall;
    function UpdateProgress(iWorkTotal: SYSUINT; iWorkSoFar: SYSUINT): HResult; stdcall;
    function ResetTimer: HResult; stdcall;
    function PauseTimer: HResult; stdcall;
    function ResumeTimer: HResult; stdcall;
  end;

  IOperationsProgressDialog = interface(IUnknown)
    ['{0C9FB851-E5C9-43EB-A370-F0677B13874C}']
    function StartProgressDialog(var hwndOwner: _RemotableHandle; Flags: LongWord): HResult; stdcall;
    function StopProgressDialog: HResult; stdcall;
    function SetOperation(action: _SPACTION): HResult; stdcall;
    function SetMode(mode: LongWord): HResult; stdcall;
    function UpdateProgress(ullPointsCurrent: Largeuint; ullPointsTotal: Largeuint; 
                            ullSizeCurrent: Largeuint; ullSizeTotal: Largeuint; 
                            ullItemsCurrent: Largeuint; ullItemsTotal: Largeuint): HResult; stdcall;
    function UpdateLocations(const psiSource: IShellItem; const psiTarget: IShellItem; 
                             const psiItem: IShellItem): HResult; stdcall;
    function ResetTimer: HResult; stdcall;
    function PauseTimer: HResult; stdcall;
    function ResumeTimer: HResult; stdcall;
    function GetMilliseconds(out pullElapsed: Largeuint; out pullRemaining: Largeuint): HResult; stdcall;
    function GetOperationStatus(out popstatus: PDOPSTATUS): HResult; stdcall;
  end;

  IPropertyChangeArray = interface(IUnknown)
    ['{380F5CAD-1B5E-42F2-805D-637FD392D31E}']
    function GetCount(out pcOperations: SYSUINT): HResult; stdcall;
    function GetAt(iIndex: SYSUINT; var riid: TGUID; out ppv: Pointer): HResult; stdcall;
    function InsertAt(iIndex: SYSUINT; const ppropChange: IPropertyChange): HResult; stdcall;
    function Append(const ppropChange: IPropertyChange): HResult; stdcall;
    function AppendOrReplace(const ppropChange: IPropertyChange): HResult; stdcall;
    function RemoveAt(iIndex: SYSUINT): HResult; stdcall;
    function IsKeyInArray(var key: _tagpropertykey): HResult; stdcall;
  end;

  IObjectWithPropertyKey = interface(IUnknown)
    ['{FC0CA0A7-C316-4FD2-9031-3E628E6D4F23}']
    function SetPropertyKey(var key: _tagpropertykey): HResult; stdcall;
    function GetPropertyKey(out pkey: _tagpropertykey): HResult; stdcall;
  end;

  IPropertyChange = interface(IObjectWithPropertyKey)
    ['{F917BC8A-1BBA-4478-A245-1BDE03EB9431}']
    function ApplyToPropVariant(var propvarIn: tag_inner_PROPVARIANT; 
                                out ppropvarOut: tag_inner_PROPVARIANT): HResult; stdcall;
  end;

  IModalWindow = interface(IUnknown)
    ['{B4DB1657-70D7-485E-8E3E-6FCB5A5C1802}']
    function RemoteShow(var hwndOwner: _RemotableHandle): HResult; stdcall;
  end;

  IFileDialog = interface(IModalWindow)
    ['{42F85136-DB7E-439C-85F1-E4075D135FC8}']
    function SetFileTypes(cFileTypes: SYSUINT; var rgFilterSpec: _COMDLG_FILTERSPEC): HResult; stdcall;
    function SetFileTypeIndex(iFileType: SYSUINT): HResult; stdcall;
    function GetFileTypeIndex(out piFileType: SYSUINT): HResult; stdcall;
    function Advise(const pfde: IFileDialogEvents; out pdwCookie: LongWord): HResult; stdcall;
    function Unadvise(dwCookie: LongWord): HResult; stdcall;
    function SetOptions(fos: LongWord): HResult; stdcall;
    function GetOptions(out pfos: LongWord): HResult; stdcall;
    function SetDefaultFolder(const psi: IShellItem): HResult; stdcall;
    function SetFolder(const psi: IShellItem): HResult; stdcall;
    function GetFolder(out ppsi: IShellItem): HResult; stdcall;
    function GetCurrentSelection(out ppsi: IShellItem): HResult; stdcall;
    function SetFileName(pszName: PWideChar): HResult; stdcall;
    function GetFileName(out pszName: PWideChar): HResult; stdcall;
    function SetTitle(pszTitle: PWideChar): HResult; stdcall;
    function SetOkButtonLabel(pszText: PWideChar): HResult; stdcall;
    function SetFileNameLabel(pszLabel: PWideChar): HResult; stdcall;
    function GetResult(out ppsi: IShellItem): HResult; stdcall;
    function AddPlace(const psi: IShellItem; FDAP: FDAP): HResult; stdcall;
    function SetDefaultExtension(pszDefaultExtension: PWideChar): HResult; stdcall;
    function Close(hr: HResult): HResult; stdcall;
    function SetClientGuid(var guid: TGUID): HResult; stdcall;
    function ClearClientData: HResult; stdcall;
    function SetFilter(const pFilter: IShellItemFilter): HResult; stdcall;
  end;

  IFileOpenDialog = interface(IFileDialog)
    ['{D57C7288-D4AD-4768-BE02-9D969532D960}']
    function GetResults(out ppenum: IShellItemArray): HResult; stdcall;
    function GetSelectedItems(out ppsai: IShellItemArray): HResult; stdcall;
  end;

  IFileDialogEvents = interface(IUnknown)
    ['{973510DB-7D7F-452B-8975-74A85828D354}']
    function OnFileOk(const pfd: IFileDialog): HResult; stdcall;
    function OnFolderChanging(const pfd: IFileDialog; const psiFolder: IShellItem): HResult; stdcall;
    function OnFolderChange(const pfd: IFileDialog): HResult; stdcall;
    function OnSelectionChange(const pfd: IFileDialog): HResult; stdcall;
    function OnShareViolation(const pfd: IFileDialog; const psi: IShellItem; 
                              out pResponse: FDE_SHAREVIOLATION_RESPONSE): HResult; stdcall;
    function OnTypeChange(const pfd: IFileDialog): HResult; stdcall;
    function OnOverwrite(const pfd: IFileDialog; const psi: IShellItem; 
                         out pResponse: FDE_OVERWRITE_RESPONSE): HResult; stdcall;
  end;

  IShellItemFilter = interface(IUnknown)
    ['{2659B475-EEB8-48B7-8F07-B378810F48CF}']
    function IncludeItem(const psi: IShellItem): HResult; stdcall;
    function GetEnumFlagsForItem(const psi: IShellItem; out pgrfFlags: LongWord): HResult; stdcall;
  end;

  IShellItemArray = interface(IUnknown)
    ['{B63EA76D-1F85-456F-A19C-48159EFA858B}']
    function BindToHandler(const pbc: IBindCtx; var bhid: TGUID; var riid: TGUID; 
                           out ppvOut: Pointer): HResult; stdcall;
    function GetPropertyStore(Flags: GETPROPERTYSTOREFLAGS; var riid: TGUID; out ppv: Pointer): HResult; stdcall;
    function GetPropertyDescriptionList(var keyType: _tagpropertykey; var riid: TGUID; 
                                        out ppv: Pointer): HResult; stdcall;
    function GetAttributes(AttribFlags: SIATTRIBFLAGS; sfgaoMask: LongWord; 
                           out psfgaoAttribs: LongWord): HResult; stdcall;
    function GetCount(out pdwNumItems: LongWord): HResult; stdcall;
    function GetItemAt(dwIndex: LongWord; out ppsi: IShellItem): HResult; stdcall;
    function EnumItems(out ppenumShellItems: IEnumShellItems): HResult; stdcall;
  end;

  IEnumShellItems = interface(IUnknown)
    ['{70629033-E363-4A28-A567-0DB78006E6D7}']
    function RemoteNext(celt: LongWord; out rgelt: IShellItem; out pceltFetched: LongWord): HResult; stdcall;
    function Skip(celt: LongWord): HResult; stdcall;
    function Reset: HResult; stdcall;
    function Clone(out ppenum: IEnumShellItems): HResult; stdcall;
  end;

  IFileSaveDialog = interface(IFileDialog)
    ['{84BCCD23-5FDE-4CDB-AEA4-AF64B83D78AB}']
    function SetSaveAsItem(const psi: IShellItem): HResult; stdcall;
    function SetProperties(const pStore: IPropertyStore): HResult; stdcall;
    function SetCollectedProperties(const pList: IPropertyDescriptionList; fAppendDefault: Integer): HResult; stdcall;
    function GetProperties(out ppStore: IPropertyStore): HResult; stdcall;
    function ApplyProperties(const psi: IShellItem; const pStore: IPropertyStore; 
                             var hwnd: _RemotableHandle; const pSink: IFileOperationProgressSink): HResult; stdcall;
  end;

  IPropertyStore = interface(IUnknown)
    ['{886D8EEB-8CF2-4446-8D02-CDBA1DBDCF99}']
    function GetCount(out cProps: LongWord): HResult; stdcall;
    function GetAt(iProp: LongWord; out pkey: _tagpropertykey): HResult; stdcall;
    function GetValue(var key: _tagpropertykey; out pv: tag_inner_PROPVARIANT): HResult; stdcall;
    function SetValue(var key: _tagpropertykey; var propvar: tag_inner_PROPVARIANT): HResult; stdcall;
    function Commit: HResult; stdcall;
  end;

  IPropertyDescriptionList = interface(IUnknown)
    ['{1F9FC1D0-C39B-4B26-817F-011967D3440E}']
    function GetCount(out pcElem: SYSUINT): HResult; stdcall;
    function GetAt(iElem: SYSUINT; var riid: TGUID; out ppv: Pointer): HResult; stdcall;
  end;

  IKnownFolderManager = interface(IUnknown)
    ['{8BE2D872-86AA-4D47-B776-32CCA40C7018}']
    function FolderIdFromCsidl(nCsidl: SYSINT; out pfid: TGUID): HResult; stdcall;
    function FolderIdToCsidl(var rfid: TGUID; out pnCsidl: SYSINT): HResult; stdcall;
    function GetFolderIds(out ppKFId: PUserType2; var pCount: SYSUINT): HResult; stdcall;
    function GetFolder(var rfid: TGUID; out ppkf: IKnownFolder): HResult; stdcall;
    function GetFolderByName(pszCanonicalName: PWideChar; out ppkf: IKnownFolder): HResult; stdcall;
    function RegisterFolder(var rfid: TGUID; var pKFD: KNOWNFOLDER_DEFINITION): HResult; stdcall;
    function UnregisterFolder(var rfid: TGUID): HResult; stdcall;
    function FindFolderFromPath(pszPath: PWideChar; mode: FFFP_MODE; out ppkf: IKnownFolder): HResult; stdcall;
    function FindFolderFromIDList(var pidl: _BYTE_BLOB; out ppkf: IKnownFolder): HResult; stdcall;
    function RemoteRedirect(var rfid: TGUID; var hwnd: _RemotableHandle; Flags: LongWord; 
                            pszTargetPath: PWideChar; cFolders: SYSUINT; var pExclusion: TGUID; 
                            out ppszError: PWideChar): HResult; stdcall;
  end;

  IKnownFolder = interface(IUnknown)
    ['{3AA7AF7E-9B36-420C-A8E3-F77D4674A488}']
    function GetId(out pkfid: TGUID): HResult; stdcall;
    function GetCategory(out pCategory: KF_CATEGORY): HResult; stdcall;
    function GetShellItem(dwFlags: LongWord; var riid: TGUID; out ppv: Pointer): HResult; stdcall;
    function GetPath(dwFlags: LongWord; out ppszPath: PWideChar): HResult; stdcall;
    function SetPath(dwFlags: LongWord; pszPath: PWideChar): HResult; stdcall;
    function GetIDList(dwFlags: LongWord; out ppidl: wirePIDL): HResult; stdcall;
    function GetFolderType(out pftid: TGUID): HResult; stdcall;
    function GetRedirectionCapabilities(out pCapabilities: LongWord): HResult; stdcall;
    function GetFolderDefinition(out pKFD: KNOWNFOLDER_DEFINITION): HResult; stdcall;
  end;

  ISharingConfigurationManager = interface(IUnknown)
    ['{B4CD448A-9C86-4466-9201-2E62105B87AE}']
    function CreateShare(dsid: DEF_SHARE_ID; role: SHARE_ROLE): HResult; stdcall;
    function DeleteShare(dsid: DEF_SHARE_ID): HResult; stdcall;
    function ShareExists(dsid: DEF_SHARE_ID): HResult; stdcall;
    function GetSharePermissions(dsid: DEF_SHARE_ID; out pRole: SHARE_ROLE): HResult; stdcall;
    function SharePrinters: HResult; stdcall;
    function StopSharingPrinters: HResult; stdcall;
    function ArePrintersShared: HResult; stdcall;
  end;

  IPreviousVersionsInfo = interface(IUnknown)
    ['{76E54780-AD74-48E3-A695-3BA9A0AFF10D}']
    function AreSnapshotsAvailable(pszPath: PWideChar; fOkToBeSlow: Integer; 
                                   out pfAvailable: Integer): HResult; stdcall;
  end;

  INameSpaceTreeControl = interface(IUnknown)
    ['{028212A3-B627-47E9-8856-C14265554E4F}']
    function Initialize(var hwndParent: _RemotableHandle; var prc: tagRECT; nsctsFlags: LongWord): HResult; stdcall;
    function TreeAdvise(const punk: IUnknown; out pdwCookie: LongWord): HResult; stdcall;
    function TreeUnadvise(dwCookie: LongWord): HResult; stdcall;
    function AppendRoot(const psiRoot: IShellItem; grfEnumFlags: LongWord; grfRootStyle: LongWord; 
                        const pif: IShellItemFilter): HResult; stdcall;
    function InsertRoot(iIndex: SYSINT; const psiRoot: IShellItem; grfEnumFlags: LongWord; 
                        grfRootStyle: LongWord; const pif: IShellItemFilter): HResult; stdcall;
    function RemoveRoot(const psiRoot: IShellItem): HResult; stdcall;
    function RemoveAllRoots: HResult; stdcall;
    function GetRootItems(out ppsiaRootItems: IShellItemArray): HResult; stdcall;
    function SetItemState(const psi: IShellItem; nstcisMask: LongWord; nstcisFlags: LongWord): HResult; stdcall;
    function GetItemState(const psi: IShellItem; nstcisMask: LongWord; out pnstcisFlags: LongWord): HResult; stdcall;
    function GetSelectedItems(out psiaItems: IShellItemArray): HResult; stdcall;
    function GetItemCustomState(const psi: IShellItem; out piStateNumber: SYSINT): HResult; stdcall;
    function SetItemCustomState(const psi: IShellItem; iStateNumber: SYSINT): HResult; stdcall;
    function EnsureItemVisible(const psi: IShellItem): HResult; stdcall;
    function SetTheme(pszTheme: PWideChar): HResult; stdcall;
    function GetNextItem(const psi: IShellItem; nstcgi: NSTCGNI; out ppsiNext: IShellItem): HResult; stdcall;
    function HitTest(var ppt: tagPOINT; out ppsiOut: IShellItem): HResult; stdcall;
    function GetItemRect(const psi: IShellItem; out prect: tagRECT): HResult; stdcall;
    function CollapseAll: HResult; stdcall;
  end;

  INameSpaceTreeControl2 = interface(INameSpaceTreeControl)
    ['{7CC7AED8-290E-49BC-8945-C1401CC9306C}']
    function SetControlStyle(nstcsMask: LongWord; nstcsStyle: LongWord): HResult; stdcall;
    function GetControlStyle(nstcsMask: LongWord; out pnstcsStyle: LongWord): HResult; stdcall;
    function SetControlStyle2(nstcsMask: NSTCSTYLE2; nstcsStyle: NSTCSTYLE2): HResult; stdcall;
    function GetControlStyle2(nstcsMask: NSTCSTYLE2; out pnstcsStyle: NSTCSTYLE2): HResult; stdcall;
  end;

  IApplicationAssociationRegistration = interface(IUnknown)
    ['{4E530B0A-E611-4C77-A3AC-9031D022281B}']
    function QueryCurrentDefault(pszQuery: PWideChar; atQueryType: ASSOCIATIONTYPE; 
                                 alQueryLevel: ASSOCIATIONLEVEL; out ppszAssociation: PWideChar): HResult; stdcall;
    function QueryAppIsDefault(pszQuery: PWideChar; atQueryType: ASSOCIATIONTYPE; 
                               alQueryLevel: ASSOCIATIONLEVEL; pszAppRegistryName: PWideChar; 
                               out pfDefault: Integer): HResult; stdcall;
    function QueryAppIsDefaultAll(alQueryLevel: ASSOCIATIONLEVEL; pszAppRegistryName: PWideChar; 
                                  out pfDefault: Integer): HResult; stdcall;
    function SetAppAsDefault(pszAppRegistryName: PWideChar; pszSet: PWideChar; 
                             atSetType: ASSOCIATIONTYPE): HResult; stdcall;
    function SetAppAsDefaultAll(pszAppRegistryName: PWideChar): HResult; stdcall;
    function ClearUserAssociations: HResult; stdcall;
  end;

  IApplicationAssociationRegistrationUI = interface(IUnknown)
    ['{1F76A169-F994-40AC-8FC8-0959E8874710}']
    function LaunchAdvancedAssociationUI(pszAppRegistryName: PWideChar): HResult; stdcall;
  end;

  ISearchFolderItemFactory = interface(IUnknown)
    ['{A0FFBC28-5482-4366-BE27-3E81E78E06C2}']
    function SetDisplayName(pszDisplayName: PWideChar): HResult; stdcall;
    function SetFolderTypeID(ftid: TGUID): HResult; stdcall;
    function SetFolderLogicalViewMode(flvm: FOLDERLOGICALVIEWMODE): HResult; stdcall;
    function SetIconSize(iIconSize: SYSINT): HResult; stdcall;
    function SetVisibleColumns(cVisibleColumns: SYSUINT; var rgKey: _tagpropertykey): HResult; stdcall;
    function SetSortColumns(cSortColumns: SYSUINT; var rgSortColumns: SORTCOLUMN): HResult; stdcall;
    function SetGroupColumn(var keyGroup: _tagpropertykey): HResult; stdcall;
    function SetStacks(cStackKeys: SYSUINT; var rgStackKeys: _tagpropertykey): HResult; stdcall;
    function SetScope(const psiaScope: IShellItemArray): HResult; stdcall;
    function SetCondition(const pCondition: ICondition): HResult; stdcall;
    function GetShellItem(var riid: TGUID; out ppv: Pointer): HResult; stdcall;
    function GetIDList(out ppidl: wirePIDL): HResult; stdcall;
  end;

  ICondition = interface(IPersistStream)
    ['{0FC988D4-C935-4B97-A973-46282EA175C8}']
    function GetConditionType(out pNodeType: tagCONDITION_TYPE): HResult; stdcall;
    function GetSubConditions(var riid: TGUID; out ppv: Pointer): HResult; stdcall;
    function RemoteGetComparisonInfo(out ppszPropertyName: PWideChar; 
                                     out pcop: tagCONDITION_OPERATION; 
                                     out ppropvar: tag_inner_PROPVARIANT): HResult; stdcall;
    function GetValueType(out ppszValueTypeName: PWideChar): HResult; stdcall;
    function GetValueNormalization(out ppszNormalization: PWideChar): HResult; stdcall;
    function RemoteGetInputTerms(out ppPropertyTerm: IRichChunk; out ppOperationTerm: IRichChunk; 
                                 out ppValueTerm: IRichChunk): HResult; stdcall;
    function Clone(out ppc: ICondition): HResult; stdcall;
  end;

  IRichChunk = interface(IUnknown)
    ['{4FDEF69C-DBC9-454E-9910-B34F3C64B510}']
    function RemoteGetData(out pFirstPos: LongWord; out pLength: LongWord; out ppsz: PWideChar; 
                           out pValue: tag_inner_PROPVARIANT): HResult; stdcall;
  end;

  IOpenControlPanel = interface(IUnknown)
    ['{D11AD862-66DE-4DF4-BF6C-1F5621996AF1}']
    function Open(pszName: PWideChar; pszPage: PWideChar; const punkSite: IUnknown): HResult; stdcall;
    function GetPath(pszName: PWideChar; pszPath: PWideChar; cchPath: SYSUINT): HResult; stdcall;
    function GetCurrentView(out pView: CPVIEW): HResult; stdcall;
  end;

  ICustomDestinationList = interface(IUnknown)
    ['{6332DEBF-87B5-4670-90C0-5E57B408A49E}']
    function SetAppID(pszAppID: PWideChar): HResult; stdcall;
    function BeginList(out pcMinSlots: SYSUINT; var riid: TGUID; out ppv: Pointer): HResult; stdcall;
    function AppendCategory(pszCategory: PWideChar; const poa: IObjectArray): HResult; stdcall;
    function AppendKnownCategory(category: KNOWNDESTCATEGORY): HResult; stdcall;
    function AddUserTasks(const poa: IObjectArray): HResult; stdcall;
    function CommitList: HResult; stdcall;
    function GetRemovedDestinations(var riid: TGUID; out ppv: Pointer): HResult; stdcall;
    function DeleteList(pszAppID: PWideChar): HResult; stdcall;
    function AbortList: HResult; stdcall;
  end;

  IObjectArray = interface(IUnknown)
    ['{92CA9DCD-5622-4BBA-A805-5E9F541BD8C9}']
    function GetCount(out pcObjects: SYSUINT): HResult; stdcall;
    function GetAt(uiIndex: SYSUINT; var riid: TGUID; out ppv: Pointer): HResult; stdcall;
  end;

  IApplicationDestinations = interface(IUnknown)
    ['{12337D35-94C6-48A0-BCE7-6A9C69D4D600}']
    function SetAppID(pszAppID: PWideChar): HResult; stdcall;
    function RemoveDestination(const punk: IUnknown): HResult; stdcall;
    function RemoveAllDestinations: HResult; stdcall;
  end;

  IApplicationDocumentLists = interface(IUnknown)
    ['{3C594F9F-9F30-47A1-979A-C9E83D3D0A06}']
    function SetAppID(pszAppID: PWideChar): HResult; stdcall;
    function GetList(listtype: APPDOCLISTTYPE; cItemsDesired: SYSUINT; var riid: TGUID; 
                     out ppv: Pointer): HResult; stdcall;
  end;

  IHomeGroup = interface(IUnknown)
    ['{7A3BD1D9-35A9-4FB3-A467-F48CAC35E2D0}']
    function IsMember(out member: Integer): HResult; stdcall;
    function ShowSharingWizard(var owner: _RemotableHandle; 
                               out sharingchoices: HOMEGROUPSHARINGCHOICES): HResult; stdcall;
  end;

  IShellLibrary = interface(IUnknown)
    ['{11A66EFA-382E-451A-9234-1E0E12EF3085}']
    function LoadLibraryFromItem(const psiLibrary: IShellItem; grfMode: LongWord): HResult; stdcall;
    function LoadLibraryFromKnownFolder(var kfidLibrary: TGUID; grfMode: LongWord): HResult; stdcall;
    function AddFolder(const psiLocation: IShellItem): HResult; stdcall;
    function RemoveFolder(const psiLocation: IShellItem): HResult; stdcall;
    function GetFolders(lff: LIBRARYFOLDERFILTER; var riid: TGUID; out ppv: Pointer): HResult; stdcall;
    function ResolveFolder(const psiFolderToResolve: IShellItem; dwTimeout: LongWord; 
                           var riid: TGUID; out ppv: Pointer): HResult; stdcall;
    function GetDefaultSaveFolder(dsft: DEFAULTSAVEFOLDERTYPE; var riid: TGUID; out ppv: Pointer): HResult; stdcall;
    function SetDefaultSaveFolder(dsft: DEFAULTSAVEFOLDERTYPE; const psi: IShellItem): HResult; stdcall;
    function GetOptions(out plofOptions: LIBRARYOPTIONFLAGS): HResult; stdcall;
    function SetOptions(lofMask: LIBRARYOPTIONFLAGS; lofOptions: LIBRARYOPTIONFLAGS): HResult; stdcall;
    function GetFolderType(out pftid: TGUID): HResult; stdcall;
    function SetFolderType(var ftid: TGUID): HResult; stdcall;
    function GetIcon(out ppszIcon: PWideChar): HResult; stdcall;
    function SetIcon(pszIcon: PWideChar): HResult; stdcall;
    function Commit: HResult; stdcall;
    function Save(const psiFolderToSaveIn: IShellItem; pszLibraryName: PWideChar; 
                  lsf: LIBRARYSAVEFLAGS; out ppsiSavedTo: IShellItem): HResult; stdcall;
    function SaveInKnownFolder(var kfidToSaveIn: TGUID; pszLibraryName: PWideChar; 
                               lsf: LIBRARYSAVEFLAGS; out ppsiSavedTo: IShellItem): HResult; stdcall;
  end;

  IEnumObjects = interface(IUnknown)
    ['{2C1C7E2E-2D0E-4059-831E-1E6F82335C2E}']
    function RemoteNext(celt: LongWord; var riid: TGUID; out rgelt: Pointer; 
                        out pceltFetched: LongWord): HResult; stdcall;
    function Skip(celt: LongWord): HResult; stdcall;
    function Reset: HResult; stdcall;
    function Clone(out ppenum: IEnumObjects): HResult; stdcall;
  end;

  IDesktopGadget = interface(IUnknown)
    ['{C1646BC4-F298-4F91-A204-EB2DD1709D1A}']
    function RunGadget(gadgetPath: PWideChar): HResult; stdcall;
  end;

implementation

uses ComObj;

end.
