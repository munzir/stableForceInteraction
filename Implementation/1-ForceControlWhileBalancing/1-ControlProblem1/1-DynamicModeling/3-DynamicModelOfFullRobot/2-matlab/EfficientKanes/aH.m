mSxg_1 = [D1*g;D2*g;D3*g];
maG_1 = [D5 + D4*ddpsi;D8 + D7*ddpsi + D6*ddx + MZ_1*ddq_imu;D11 + D10*ddpsi + D9*ddx - MY_1*ddq_imu];
dHnew_1 = [D14 + D13*ddpsi + D12*ddx - XX_1*ddq_imu;D17 + D16*ddpsi + D15*ddx - XY_1*ddq_imu;D20 + D19*ddpsi + D18*ddx - XZ_1*ddq_imu];
mSxg_2 = [D21*g;D22*g;D23*g];
maG_2 = [D25 + D24*ddpsi;D29 + D27*ddpsi + D28*ddq_imu + D26*ddx + MZ_2*ddq_w;D33 + D31*ddpsi + D32*ddq_imu + D30*ddx - MY_2*ddq_w];
dHnew_2 = [D37 + D35*ddpsi + D36*ddq_imu + D34*ddx - XX_2*ddq_w;D41 + D39*ddpsi + D40*ddq_imu + D38*ddx - XY_2*ddq_w;D45 + D43*ddpsi + D44*ddq_imu + D42*ddx - XZ_2*ddq_w];
mSxg_3 = [D46*g;D47*g;D48*g];
maG_3 = [D53 + D50*ddpsi + D52*ddq_w + D51*ddq_imu + D49*ddx - MZ_3*ddq_torso;D58 + D55*ddpsi + D57*ddq_w + D56*ddq_imu + D54*ddx;D63 + D60*ddpsi + D62*ddq_w + D61*ddq_imu + D59*ddx + MX_3*ddq_torso];
dHnew_3 = [D68 + D65*ddpsi + D67*ddq_w + D66*ddq_imu + D64*ddx - XY_3*ddq_torso;D73 + D70*ddpsi + D72*ddq_w + D71*ddq_imu + D69*ddx - YY_3*ddq_torso;D78 + D75*ddpsi + D77*ddq_w + D76*ddq_imu + D74*ddx - YZ_3*ddq_torso];
mSxg_4l = [D1l*g;D2l*g;D3l*g];
maG_4l = [D9l + D5l*ddpsi + D7l*ddq_w + D6l*ddq_imu + D8l*ddq_torso + D4l*ddx - MZ_4l*ddq_1l;D15l + D11l*ddpsi + D13l*ddq_w + D12l*ddq_imu + D14l*ddq_torso + D10l*ddx;D21l + D17l*ddpsi + D19l*ddq_w + D18l*ddq_imu + D20l*ddq_torso + D16l*ddx + MX_4l*ddq_1l];
dHnew_4l = [D27l + D23l*ddpsi + D25l*ddq_w + D24l*ddq_imu + D26l*ddq_torso + D22l*ddx - XY_4l*ddq_1l;D33l + D29l*ddpsi + D31l*ddq_w + D30l*ddq_imu + D32l*ddq_torso + D28l*ddx - YY_4l*ddq_1l;D39l + D35l*ddpsi + D37l*ddq_w + D36l*ddq_imu + D38l*ddq_torso + D34l*ddx - YZ_4l*ddq_1l];
mSxg_5l = [D40l*g;D41l*g;D42l*g];
maG_5l = [D49l + D44l*ddpsi + D48l*ddq_1l + D46l*ddq_w + D45l*ddq_imu + D47l*ddq_torso + D43l*ddx;D56l + D51l*ddpsi + D55l*ddq_1l + D53l*ddq_w + D52l*ddq_imu + D54l*ddq_torso + D50l*ddx + MZ_5l*ddq_2l;D63l + D58l*ddpsi + D62l*ddq_1l + D60l*ddq_w + D59l*ddq_imu + D61l*ddq_torso + D57l*ddx - MY_5l*ddq_2l];
dHnew_5l = [D70l + D65l*ddpsi + D69l*ddq_1l + D67l*ddq_w + D66l*ddq_imu + D68l*ddq_torso + D64l*ddx - XX_5l*ddq_2l;D77l + D72l*ddpsi + D76l*ddq_1l + D74l*ddq_w + D73l*ddq_imu + D75l*ddq_torso + D71l*ddx - XY_5l*ddq_2l;D84l + D79l*ddpsi + D83l*ddq_1l + D81l*ddq_w + D80l*ddq_imu + D82l*ddq_torso + D78l*ddx - XZ_5l*ddq_2l];
mSxg_6l = [D85l*g;D86l*g;D87l*g];
maG_6l = [D95l + D89l*ddpsi + D93l*ddq_1l + D94l*ddq_2l + D91l*ddq_w + D90l*ddq_imu + D92l*ddq_torso + D88l*ddx - MZ_6l*ddq_3l;D103l + D97l*ddpsi + D101l*ddq_1l + D102l*ddq_2l + D99l*ddq_w + D98l*ddq_imu + D100l*ddq_torso + D96l*ddx;D111l + D105l*ddpsi + D109l*ddq_1l + D110l*ddq_2l + D107l*ddq_w + D106l*ddq_imu + D108l*ddq_torso + D104l*ddx + MX_6l*ddq_3l];
dHnew_6l = [D119l + D113l*ddpsi + D117l*ddq_1l + D118l*ddq_2l + D115l*ddq_w + D114l*ddq_imu + D116l*ddq_torso + D112l*ddx - XY_6l*ddq_3l;D127l + D121l*ddpsi + D125l*ddq_1l + D126l*ddq_2l + D123l*ddq_w + D122l*ddq_imu + D124l*ddq_torso + D120l*ddx - YY_6l*ddq_3l;D135l + D129l*ddpsi + D133l*ddq_1l + D134l*ddq_2l + D131l*ddq_w + D130l*ddq_imu + D132l*ddq_torso + D128l*ddx - YZ_6l*ddq_3l];
mSxg_7l = [D136l*g;D137l*g;D138l*g];
maG_7l = [D147l + D140l*ddpsi + D144l*ddq_1l + D145l*ddq_2l + D146l*ddq_3l + D142l*ddq_w + D141l*ddq_imu + D143l*ddq_torso + D139l*ddx;D156l + D149l*ddpsi + D153l*ddq_1l + D154l*ddq_2l + D155l*ddq_3l + D151l*ddq_w + D150l*ddq_imu + D152l*ddq_torso + D148l*ddx + MZ_7l*ddq_4l;D165l + D158l*ddpsi + D162l*ddq_1l + D163l*ddq_2l + D164l*ddq_3l + D160l*ddq_w + D159l*ddq_imu + D161l*ddq_torso + D157l*ddx - MY_7l*ddq_4l];
dHnew_7l = [D174l + D167l*ddpsi + D171l*ddq_1l + D172l*ddq_2l + D173l*ddq_3l + D169l*ddq_w + D168l*ddq_imu + D170l*ddq_torso + D166l*ddx - XX_7l*ddq_4l;D183l + D176l*ddpsi + D180l*ddq_1l + D181l*ddq_2l + D182l*ddq_3l + D178l*ddq_w + D177l*ddq_imu + D179l*ddq_torso + D175l*ddx - XY_7l*ddq_4l;D192l + D185l*ddpsi + D189l*ddq_1l + D190l*ddq_2l + D191l*ddq_3l + D187l*ddq_w + D186l*ddq_imu + D188l*ddq_torso + D184l*ddx - XZ_7l*ddq_4l];
mSxg_8l = [D193l*g;D194l*g;D195l*g];
maG_8l = [D205l + D197l*ddpsi + D201l*ddq_1l + D202l*ddq_2l + D203l*ddq_3l + D204l*ddq_4l + D199l*ddq_w + D198l*ddq_imu + D200l*ddq_torso + D196l*ddx - MZ_8l*ddq_5l;D215l + D207l*ddpsi + D211l*ddq_1l + D212l*ddq_2l + D213l*ddq_3l + D214l*ddq_4l + D209l*ddq_w + D208l*ddq_imu + D210l*ddq_torso + D206l*ddx;D225l + D217l*ddpsi + D221l*ddq_1l + D222l*ddq_2l + D223l*ddq_3l + D224l*ddq_4l + D219l*ddq_w + D218l*ddq_imu + D220l*ddq_torso + D216l*ddx + MX_8l*ddq_5l];
dHnew_8l = [D235l + D227l*ddpsi + D231l*ddq_1l + D232l*ddq_2l + D233l*ddq_3l + D234l*ddq_4l + D229l*ddq_w + D228l*ddq_imu + D230l*ddq_torso + D226l*ddx - XY_8l*ddq_5l;D245l + D237l*ddpsi + D241l*ddq_1l + D242l*ddq_2l + D243l*ddq_3l + D244l*ddq_4l + D239l*ddq_w + D238l*ddq_imu + D240l*ddq_torso + D236l*ddx - YY_8l*ddq_5l;D255l + D247l*ddpsi + D251l*ddq_1l + D252l*ddq_2l + D253l*ddq_3l + D254l*ddq_4l + D249l*ddq_w + D248l*ddq_imu + D250l*ddq_torso + D246l*ddx - YZ_8l*ddq_5l];
mSxg_9l = [D256l*g;D257l*g;D258l*g];
maG_9l = [D269l + D260l*ddpsi + D264l*ddq_1l + D265l*ddq_2l + D266l*ddq_3l + D267l*ddq_4l + D262l*ddq_w + D268l*ddq_5l + D261l*ddq_imu + D263l*ddq_torso + D259l*ddx;D280l + D271l*ddpsi + D275l*ddq_1l + D276l*ddq_2l + D277l*ddq_3l + D278l*ddq_4l + D273l*ddq_w + D279l*ddq_5l + D272l*ddq_imu + D274l*ddq_torso + D270l*ddx + MZ_9l*ddq_6l;D291l + D282l*ddpsi + D286l*ddq_1l + D287l*ddq_2l + D288l*ddq_3l + D289l*ddq_4l + D284l*ddq_w + D290l*ddq_5l + D283l*ddq_imu + D285l*ddq_torso + D281l*ddx - MY_9l*ddq_6l];
dHnew_9l = [D302l + D293l*ddpsi + D297l*ddq_1l + D298l*ddq_2l + D299l*ddq_3l + D300l*ddq_4l + D295l*ddq_w + D301l*ddq_5l + D294l*ddq_imu + D296l*ddq_torso + D292l*ddx - XX_9l*ddq_6l;D313l + D304l*ddpsi + D308l*ddq_1l + D309l*ddq_2l + D310l*ddq_3l + D311l*ddq_4l + D306l*ddq_w + D312l*ddq_5l + D305l*ddq_imu + D307l*ddq_torso + D303l*ddx - XY_9l*ddq_6l;D324l + D315l*ddpsi + D319l*ddq_1l + D320l*ddq_2l + D321l*ddq_3l + D322l*ddq_4l + D317l*ddq_w + D323l*ddq_5l + D316l*ddq_imu + D318l*ddq_torso + D314l*ddx - XZ_9l*ddq_6l];
mSxg_10l = [D325l*g;D326l*g;D327l*g];
maG_10l = [D339l + D329l*ddpsi + D333l*ddq_1l + D334l*ddq_2l + D335l*ddq_3l + D336l*ddq_4l + D331l*ddq_w + D337l*ddq_5l + D338l*ddq_6l + D330l*ddq_imu + D332l*ddq_torso + D328l*ddx + MY_10l*ddq_7l;D351l + D341l*ddpsi + D345l*ddq_1l + D346l*ddq_2l + D347l*ddq_3l + D348l*ddq_4l + D343l*ddq_w + D349l*ddq_5l + D350l*ddq_6l + D342l*ddq_imu + D344l*ddq_torso + D340l*ddx - MX_10l*ddq_7l;D363l + D353l*ddpsi + D357l*ddq_1l + D358l*ddq_2l + D359l*ddq_3l + D360l*ddq_4l + D355l*ddq_w + D361l*ddq_5l + D362l*ddq_6l + D354l*ddq_imu + D356l*ddq_torso + D352l*ddx];
dHnew_10l = [D375l + D365l*ddpsi + D369l*ddq_1l + D370l*ddq_2l + D371l*ddq_3l + D372l*ddq_4l + D367l*ddq_w + D373l*ddq_5l + D374l*ddq_6l + D366l*ddq_imu + D368l*ddq_torso + D364l*ddx - XZ_10l*ddq_7l;D387l + D377l*ddpsi + D381l*ddq_1l + D382l*ddq_2l + D383l*ddq_3l + D384l*ddq_4l + D379l*ddq_w + D385l*ddq_5l + D386l*ddq_6l + D378l*ddq_imu + D380l*ddq_torso + D376l*ddx - YZ_10l*ddq_7l;D399l + D389l*ddpsi + D393l*ddq_1l + D394l*ddq_2l + D395l*ddq_3l + D396l*ddq_4l + D391l*ddq_w + D397l*ddq_5l + D398l*ddq_6l + D390l*ddq_imu + D392l*ddq_torso + D388l*ddx - ZZ_10l*ddq_7l];
mSxg_4r = [D1r*g;D2r*g;D3r*g];
maG_4r = [D9r + D5r*ddpsi + D7r*ddq_w + D6r*ddq_imu + D8r*ddq_torso + D4r*ddx - MZ_4r*ddq_1r;D15r + D11r*ddpsi + D13r*ddq_w + D12r*ddq_imu + D14r*ddq_torso + D10r*ddx;D21r + D17r*ddpsi + D19r*ddq_w + D18r*ddq_imu + D20r*ddq_torso + D16r*ddx + MX_4r*ddq_1r];
dHnew_4r = [D27r + D23r*ddpsi + D25r*ddq_w + D24r*ddq_imu + D26r*ddq_torso + D22r*ddx - XY_4r*ddq_1r;D33r + D29r*ddpsi + D31r*ddq_w + D30r*ddq_imu + D32r*ddq_torso + D28r*ddx - YY_4r*ddq_1r;D39r + D35r*ddpsi + D37r*ddq_w + D36r*ddq_imu + D38r*ddq_torso + D34r*ddx - YZ_4r*ddq_1r];
mSxg_5r = [D40r*g;D41r*g;D42r*g];
maG_5r = [D49r + D44r*ddpsi + D48r*ddq_1r + D46r*ddq_w + D45r*ddq_imu + D47r*ddq_torso + D43r*ddx;D56r + D51r*ddpsi + D55r*ddq_1r + D53r*ddq_w + D52r*ddq_imu + D54r*ddq_torso + D50r*ddx + MZ_5r*ddq_2r;D63r + D58r*ddpsi + D62r*ddq_1r + D60r*ddq_w + D59r*ddq_imu + D61r*ddq_torso + D57r*ddx - MY_5r*ddq_2r];
dHnew_5r = [D70r + D65r*ddpsi + D69r*ddq_1r + D67r*ddq_w + D66r*ddq_imu + D68r*ddq_torso + D64r*ddx - XX_5r*ddq_2r;D77r + D72r*ddpsi + D76r*ddq_1r + D74r*ddq_w + D73r*ddq_imu + D75r*ddq_torso + D71r*ddx - XY_5r*ddq_2r;D84r + D79r*ddpsi + D83r*ddq_1r + D81r*ddq_w + D80r*ddq_imu + D82r*ddq_torso + D78r*ddx - XZ_5r*ddq_2r];
mSxg_6r = [D85r*g;D86r*g;D87r*g];
maG_6r = [D95r + D89r*ddpsi + D93r*ddq_1r + D91r*ddq_w + D94r*ddq_2r + D90r*ddq_imu + D92r*ddq_torso + D88r*ddx - MZ_6r*ddq_3r;D103r + D97r*ddpsi + D101r*ddq_1r + D99r*ddq_w + D102r*ddq_2r + D98r*ddq_imu + D100r*ddq_torso + D96r*ddx;D111r + D105r*ddpsi + D109r*ddq_1r + D107r*ddq_w + D110r*ddq_2r + D106r*ddq_imu + D108r*ddq_torso + D104r*ddx + MX_6r*ddq_3r];
dHnew_6r = [D119r + D113r*ddpsi + D117r*ddq_1r + D115r*ddq_w + D118r*ddq_2r + D114r*ddq_imu + D116r*ddq_torso + D112r*ddx - XY_6r*ddq_3r;D127r + D121r*ddpsi + D125r*ddq_1r + D123r*ddq_w + D126r*ddq_2r + D122r*ddq_imu + D124r*ddq_torso + D120r*ddx - YY_6r*ddq_3r;D135r + D129r*ddpsi + D133r*ddq_1r + D131r*ddq_w + D134r*ddq_2r + D130r*ddq_imu + D132r*ddq_torso + D128r*ddx - YZ_6r*ddq_3r];
mSxg_7r = [D136r*g;D137r*g;D138r*g];
maG_7r = [D147r + D140r*ddpsi + D144r*ddq_1r + D142r*ddq_w + D145r*ddq_2r + D146r*ddq_3r + D141r*ddq_imu + D143r*ddq_torso + D139r*ddx;D156r + D149r*ddpsi + D153r*ddq_1r + D151r*ddq_w + D154r*ddq_2r + D155r*ddq_3r + D150r*ddq_imu + D152r*ddq_torso + D148r*ddx + MZ_7r*ddq_4r;D165r + D158r*ddpsi + D162r*ddq_1r + D160r*ddq_w + D163r*ddq_2r + D164r*ddq_3r + D159r*ddq_imu + D161r*ddq_torso + D157r*ddx - MY_7r*ddq_4r];
dHnew_7r = [D174r + D167r*ddpsi + D171r*ddq_1r + D169r*ddq_w + D172r*ddq_2r + D173r*ddq_3r + D168r*ddq_imu + D170r*ddq_torso + D166r*ddx - XX_7r*ddq_4r;D183r + D176r*ddpsi + D180r*ddq_1r + D178r*ddq_w + D181r*ddq_2r + D182r*ddq_3r + D177r*ddq_imu + D179r*ddq_torso + D175r*ddx - XY_7r*ddq_4r;D192r + D185r*ddpsi + D189r*ddq_1r + D187r*ddq_w + D190r*ddq_2r + D191r*ddq_3r + D186r*ddq_imu + D188r*ddq_torso + D184r*ddx - XZ_7r*ddq_4r];
mSxg_8r = [D193r*g;D194r*g;D195r*g];
maG_8r = [D205r + D197r*ddpsi + D201r*ddq_1r + D199r*ddq_w + D202r*ddq_2r + D203r*ddq_3r + D204r*ddq_4r + D198r*ddq_imu + D200r*ddq_torso + D196r*ddx - MZ_8r*ddq_5r;D215r + D207r*ddpsi + D211r*ddq_1r + D209r*ddq_w + D212r*ddq_2r + D213r*ddq_3r + D214r*ddq_4r + D208r*ddq_imu + D210r*ddq_torso + D206r*ddx;D225r + D217r*ddpsi + D221r*ddq_1r + D219r*ddq_w + D222r*ddq_2r + D223r*ddq_3r + D224r*ddq_4r + D218r*ddq_imu + D220r*ddq_torso + D216r*ddx + MX_8r*ddq_5r];
dHnew_8r = [D235r + D227r*ddpsi + D231r*ddq_1r + D229r*ddq_w + D232r*ddq_2r + D233r*ddq_3r + D234r*ddq_4r + D228r*ddq_imu + D230r*ddq_torso + D226r*ddx - XY_8r*ddq_5r;D245r + D237r*ddpsi + D241r*ddq_1r + D239r*ddq_w + D242r*ddq_2r + D243r*ddq_3r + D244r*ddq_4r + D238r*ddq_imu + D240r*ddq_torso + D236r*ddx - YY_8r*ddq_5r;D255r + D247r*ddpsi + D251r*ddq_1r + D249r*ddq_w + D252r*ddq_2r + D253r*ddq_3r + D254r*ddq_4r + D248r*ddq_imu + D250r*ddq_torso + D246r*ddx - YZ_8r*ddq_5r];
mSxg_9r = [D256r*g;D257r*g;D258r*g];
maG_9r = [D269r + D260r*ddpsi + D264r*ddq_1r + D262r*ddq_w + D265r*ddq_2r + D266r*ddq_3r + D267r*ddq_4r + D268r*ddq_5r + D261r*ddq_imu + D263r*ddq_torso + D259r*ddx;D280r + D271r*ddpsi + D275r*ddq_1r + D273r*ddq_w + D276r*ddq_2r + D277r*ddq_3r + D278r*ddq_4r + D279r*ddq_5r + D272r*ddq_imu + D274r*ddq_torso + D270r*ddx + MZ_9r*ddq_6r;D291r + D282r*ddpsi + D286r*ddq_1r + D284r*ddq_w + D287r*ddq_2r + D288r*ddq_3r + D289r*ddq_4r + D290r*ddq_5r + D283r*ddq_imu + D285r*ddq_torso + D281r*ddx - MY_9r*ddq_6r];
dHnew_9r = [D302r + D293r*ddpsi + D297r*ddq_1r + D295r*ddq_w + D298r*ddq_2r + D299r*ddq_3r + D300r*ddq_4r + D301r*ddq_5r + D294r*ddq_imu + D296r*ddq_torso + D292r*ddx - XX_9r*ddq_6r;D313r + D304r*ddpsi + D308r*ddq_1r + D306r*ddq_w + D309r*ddq_2r + D310r*ddq_3r + D311r*ddq_4r + D312r*ddq_5r + D305r*ddq_imu + D307r*ddq_torso + D303r*ddx - XY_9r*ddq_6r;D324r + D315r*ddpsi + D319r*ddq_1r + D317r*ddq_w + D320r*ddq_2r + D321r*ddq_3r + D322r*ddq_4r + D323r*ddq_5r + D316r*ddq_imu + D318r*ddq_torso + D314r*ddx - XZ_9r*ddq_6r];
mSxg_10r = [D325r*g;D326r*g;D327r*g];
maG_10r = [D339r + D329r*ddpsi + D333r*ddq_1r + D331r*ddq_w + D334r*ddq_2r + D335r*ddq_3r + D336r*ddq_4r + D337r*ddq_5r + D338r*ddq_6r + D330r*ddq_imu + D332r*ddq_torso + D328r*ddx + MY_10r*ddq_7r;D351r + D341r*ddpsi + D345r*ddq_1r + D343r*ddq_w + D346r*ddq_2r + D347r*ddq_3r + D348r*ddq_4r + D349r*ddq_5r + D350r*ddq_6r + D342r*ddq_imu + D344r*ddq_torso + D340r*ddx - MX_10r*ddq_7r;D363r + D353r*ddpsi + D357r*ddq_1r + D355r*ddq_w + D358r*ddq_2r + D359r*ddq_3r + D360r*ddq_4r + D361r*ddq_5r + D362r*ddq_6r + D354r*ddq_imu + D356r*ddq_torso + D352r*ddx];
dHnew_10r = [D375r + D365r*ddpsi + D369r*ddq_1r + D367r*ddq_w + D370r*ddq_2r + D371r*ddq_3r + D372r*ddq_4r + D373r*ddq_5r + D374r*ddq_6r + D366r*ddq_imu + D368r*ddq_torso + D364r*ddx - XZ_10r*ddq_7r;D387r + D377r*ddpsi + D381r*ddq_1r + D379r*ddq_w + D382r*ddq_2r + D383r*ddq_3r + D384r*ddq_4r + D385r*ddq_5r + D386r*ddq_6r + D378r*ddq_imu + D380r*ddq_torso + D376r*ddx - YZ_10r*ddq_7r;D399r + D389r*ddpsi + D393r*ddq_1r + D391r*ddq_w + D394r*ddq_2r + D395r*ddq_3r + D396r*ddq_4r + D397r*ddq_5r + D398r*ddq_6r + D390r*ddq_imu + D392r*ddq_torso + D388r*ddx - ZZ_10r*ddq_7r];