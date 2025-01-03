--
-- Copyright (c) 2024 outdead.
-- Use of this source code is governed by the Apache 2.0 license.
--
-- Permanent Effects Drinks adds drinks with a permanent effect
--

function MoonshineStillBuildEnabled(param)
    return SandboxVars.Permanent.CanBuildMoonshineStill or isAdmin();
end
