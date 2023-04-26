    var du = new DeviceUUID().parse();
    var dua = [
        du.language,
        du.platform,
        du.os,
        du.cpuCores,
        du.isAuthoritative,
        du.silkAccelerated,
        du.isKindleFire,
        du.isDesktop,
        du.isMobile,
        du.isTablet,
        du.isWindows,
        du.isLinux,
        du.isLinux64,
        du.isMac,
        du.isiPad,
        du.isiPhone,
        du.isiPod,
        du.isSmartTV,
        du.pixelDepth,
        du.isTouchScreen
    ];
    var uuid = du.hashMD5(dua.join(':'));
    var browserVersion = du.version;
    var browserType = du.browser;
    var os = du.os;