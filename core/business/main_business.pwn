//  CREDITOS
//  Artic, 18/Abril

//  DEFINES
#define MAX_BUSINESS 50
#define MAX_BUSINESS_RANKS 10
#define INVALID_BUSINESS_ID -1

#define DESBUG_PLAYER_BUSINESS

//  ENUM
enum
{
	DIALOG_DESBUG = 0,  //  Cambiar 0 Por la ϊltima ID disponible.
	DIALOG_BUSINESS,
	DIALOG_MECHANIC_MENU,
	DIALOG_COLOR_ONE,
	DIALOG_COLOR_TWO,
	DIALOG_MEMBERS
}

enum 
{
	BUSINESS_NONE,
	BUSINESS_MECHANIC,
	BUSINESS_CARDEALER,
	BUSINESS_LICENCES,
	BUSINESS_SECURITY,
	BUSINESS_NEWSLETTER,
	BUSINESS_FUNERAL,
	BUSINESS_ASEGURADOR,
	BUSINESS_INVALID
}

//  TIPOS DE PICKUP
enum
{
	PICKUP_NONE_BIZZ = 0,
	PICKUP_INTERIOR_BIZZ,
	PICKUP_EXTERIOR_BIZZ,
	PICKUP_SHOP_BIZZ,
	PICKUP_REPAIR_MECHANIC,
}

enum business_info
{
	//  INFORMACIΣN GENERAL
	//  SQL
	business_ID,								//  ID SQL
	bool:business_valid,						//  Empresa vαlida y creada
	business_type,								//  Tipo de empresa
	business_name[32],							//  Nombre de la empresa
	//  Informaciσn de la empresa
	business_owner,								//  ID sql del propietario
	business_money,								//  Dinero en caja fuerte
	business_sold,								//  Vendido o no
	business_price,								//  Precio de la venta
	//  Map icon
	business_mapicon,							//  ID mapicon
	business_iconid,							//  tipo mapicon
	//  Posiciones
	Float:business_IntX,						//  Coordenada Interior de X
	Float:business_IntY,						//  Coordenada Interior de Y
	Float:business_IntZ,						//  Coordenada Interior de Z
	Float:business_ExtX,						//  Coordenada Exterior de X
	Float:business_ExtY,						//  Coordenada Exterior de Y
	Float:business_ExtZ,						//  Coordenada Exterior de Z
	//  Interior y Virtual World
	business_IntInterior,						//  ID del Interior Interior (XD)
	business_IntWorld,							//  ID del Virtual World Interior (XD)
	business_ExtInterior,						//  ID del Interior Exterior (XD)
	business_ExtWorld,							//  ID del Virtual World Exterior (XD)
	//  Pickup interior y exterior
	business_IntPickup,							//  ID Pickup interior compra
	business_ExtPickup,							//  ID Pickup exterior compra
	//  Label interior y Exterior
	Text3D:business_IntLabel,					//  Label interior
	Text3D:business_ExtLabel,					//  Label exterior
	//  DISTRIBUCIΣN SEGΪN EL TIPO DE EMPRESA
	//  MECΑNICO
	//  Label reparaciσn
	Text3D:mechanic_label,						//  Label reparaciσn
	//  Posiciones de reparaciσn
	Float:mechanic_repairX,						//  Coordenada reparaciσn X
	Float:mechanic_repairY,						//  Coordenada reparaciσn Y
	Float:mechanic_repairZ,						//  Coordenada reparaciσn Z
	Float:mechanic_repairR,						//  Coordenada reparaciσn R
	mechanic_interior,							//  Interior del /taller
	mechanic_world,								//  Virtual world del /taller
	//  Precios
	mechanic_price_repair,						//  Precio de reparaciσn
	mechanic_price_colour,						//  Precio de pintura
	mechanic_price_gas,							//  Precio de gasolina
	mechanic_price_oil,							//  Precio de aceite
	bool:mechanic_charge,						//  Cobrar al usar el /taller
	//  EMPLEADOS
	business_maxranks							//  mαximo de rangos
}
new Business_Info[MAX_BUSINESS][business_info];

//  Rangos
new Business_Ranks[MAX_BUSINESS][MAX_BUSINESS_RANKS][MAX_PLAYER_NAME];

//  others
new 
	MySQL:handle_business,
	total_business
;

//  DEFINES 
#if defined DESBUG_PLAYER_BUSINESS
	#define GetPlayerBusiness(%0) PlayerBusiness[%0][player_employee]
	#define IsPlayerOwner(%0,%1) (PlayerBusiness[%0][player_rank] == Business_Info[%1][business_maxranks])
#else
	#define GetPlayerBusiness(%0) IsPlayerAdmin(%0)
	#define IsPlayerOwner(%0) IsPlayerAdmin(%0)
#endif
/*
DESBUG_PLAYER_BUSINESS definido para crear un enum de jugador, puede causar bugs con el enum principal, es necesario
adaptarlo.

Se verifica el ser Administrador RCON de manera temporal, puesto a que no se tiene en estos mσdulos
la informaciσn del jugador (Enum), por lo que hacer un enum aparte tendrνa poco sentido; ademαs de tener
que incluir un nuevo guardado de datos, que podrνa interferir con el guardado principal (gamemode)

enum "PlayerBusiness" creado temporalmente para el testeo.
*/

//  MΣDULOS
//  General
#include "../core/business/player_business.pwn"
#include "../core/business/commands_business.pwn"
#include "../core/business/functions_business.pwn"
//  Taller mecαnico
#include "../core/business/mechanic_business.pwn"