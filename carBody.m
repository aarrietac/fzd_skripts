function car = carBody()

    mm2m = 0.001;

    carx0 = [13579.81810468, 1145.46096095];

    carShp = [13587.95570457,645.00847901;
            14556.31072457,750.79522697;
            14861.46445468,1226.83536492;
            14861.46445468,2248.0837589;
            14658.02855866,2244.01484503;
            14519.69209468,2789.2233289;
            14601.06649866,2960.1095089;
            14698.71587457,2992.65922492;
            14694.64718855,3265.26323901;
            14584.79175457,3501.2490789;
            13234.07571695,4744.03112676;
            11312.22730625,5031.73304877;
            6927.65111755,5112.28947757;
            3958.56799325,3558.69941768;
            1536.11854356,3190.44106687;
            454.35955831,2850.95288548;
            166.65772744,2517.21878354;
            34.31485698,1366.41132333;
            91.85524138,791.00770715;
            615.47259818,537.830034;
            1518.85630521,445.7654463;
            1607.67018207,451.56919667;
            1610.92089291,624.14054225;
            1616.67497236,1067.20147026;
            1668.51181405,1422.92953496;
            1841.13283055,1745.15570584;
            2013.75384705,1952.30097121;
            2266.93152019,2136.43014661;
            2554.63344221,2274.52714209;
            2865.35145419,2343.57563983;
            3164.56130726,2332.06748093;
            3429.24713931,2286.03507315;
            3739.96492344,2136.43014661;
            4004.65075549,1929.28488125;
            4177.27177199,1699.12329806;
            4315.36876746,1445.94585277;
            4407.43335517,1112.21152298;
            4407.43335517,513.79181684;
            10759.8901345,582.84031458;
            10771.3982934,1100.70359192;
            10828.93863224,1422.92953496;
            11013.06780764,1768.1717958;
            11254.73732188,2055.87371782;
            11599.97958273,2286.03507315;
            12002.76218241,2389.60781976;
            12394.03662318,2378.09966085;
            12796.81922286,2251.51105213;
            13096.02930378,2044.36555891;
            13372.22306689,1756.66386475;
            13521.82799342,1445.94585277;
            13587.95570457,645.00847901];

    carShp = carShp - carx0;
    carShp = carShp*mm2m;

    xmin = min(carShp(:,1)); xmax = max(carShp(:,1));
    ymin = min(carShp(:,2)); ymax = max(carShp(:,2));
    r0 = 0.31;
    carW = 4.191; carH = 1.508 - r0;

    offset = 0.4; wb = 2.595;

    xCar = carShp(:,1)*carW/abs(xmax - xmin); xCar = xCar - min(xCar);
    yCar = carShp(:,2)*carH/abs(ymax - ymin) + offset;

    car.shape.x  = xCar;
    car.shape.y  = yCar;
    car.shape.wb = wb;
    car.tire.r0  = r0;

%     line(xCar, yCar, 'LineWidth', 3), hold on
%     viscircles([0.85, r0], r0, 'Color', 'k', 'LineWidth', 3);
%     viscircles([0.85 + wb, r0], r0, 'Color', 'k', 'LineWidth', 3);
%     grid on
%     axis('equal')

end