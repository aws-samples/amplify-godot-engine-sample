@tool
extends Resource
class_name GameStyle

enum Id {
	ANIME,           # Japanese animation style
	CARTOON,         # Playful animated style 
	CLAYMATION,      # Clay-like stop motion
	COMIC_BOOK,      # Comic/manga inspired
	HAND_DRAWN_2D,   # Traditional art look
	LOW_POLY,        # Minimal polygon 3D
	MINIMALIST,      # Simple geometric style
	PIXEL_ART,       # Classic pixel graphics
	REALISTIC_3D,    # Photorealistic 3D
	RETRO,           # Classic game style
	STYLIZED_3D,     # Artistic 3D style
	VOXEL,           # Block-based 3D
	WATERCOLOR       # Painted water media
}

# Instance variables
@export var id: Id
@export var name: String 
@export var description: String
@export var notable_games: Array[String]
@export var artistic_style: String      # Visual style/medium description
@export var technical_specs: String     # Rendering and technical style aspects
@export var quality_specs: String       # Quality and fidelity descriptors 

func _init(p_id: Id = Id.PIXEL_ART,
		p_name: String = "",
		p_description: String = "",
		p_notable_games: Array[String] = [],
		p_artistic_style: String = "",
		p_technical_specs: String = "",
		p_quality_specs: String = "") -> void:
	
	id = p_id
	name = p_name
	description = p_description
	notable_games = p_notable_games
	artistic_style = p_artistic_style
	technical_specs = p_technical_specs
	quality_specs = p_quality_specs

func _to_string() -> String:
	return "GameStyle(%s)" % name

static var ANIME := GameStyle.new(
	Id.ANIME,
	"Anime",
	"Japanese animation-inspired style featuring distinctive character designs, cel-shading, and expressive animations.",
	["Persona 5", "Dragon Ball FighterZ", "Genshin Impact", "Tales of Arise", "Scarlet Nexus"],
	"vibrant cel-shaded animation with bold outlines, expressive character features and striking compositions",
	"crisp toon shading with dramatic lighting, stylized effects and dynamic camera movement",
	"high-fidelity character detail with clean line work, vivid color saturation and fluid motion"
)

static var CARTOON := GameStyle.new(
	Id.CARTOON,
	"Cartoon",
	"Playful and exaggerated visual style inspired by traditional animation, featuring bold colors, smooth shapes, and whimsical character designs.",
	["Super Mario Odyssey", "Crash Bandicoot 4", "Fall Guys", "Rayman Legends", "Spyro Reignited Trilogy"],
	"playful animated style with soft rounded shapes, exaggerated proportions and bright cheerful colors",
	"smooth flowing animation with bouncy character movement, elastic deformation and whimsical effects",
	"polished rendering with seamless color transitions, perfect edge clarity and dynamic motion"
)

static var CLAYMATION := GameStyle.new(
	Id.CLAYMATION,
	"Claymation",
	"Digital style mimicking stop-motion clay animation, featuring distinctive textures, slightly imperfect movements, and handcrafted aesthetics.",
	["Armikrog", "The Neverhood", "Harold Halibut", "Skullmonkeys", "The Dream Machine"],
	"handcrafted clay-like surfaces with subtle texture details and organic shapes",
	"stepped animation with physical material simulation and tactile surface qualities",
	"high-resolution material detail with natural imperfections and authentic stop-motion feel"
)

static var COMIC_BOOK := GameStyle.new(
	Id.COMIC_BOOK,
	"Comic Book",
	"Style emulating comic books and graphic novels with bold outlines, cel-shading, and dynamic visual effects.",
	["Ultimate Spider-Man", "XIII", "Viewtiful Joe", "Sable", "Comic Jumper"],
	"bold graphic style with strong outlines, dynamic poses and vibrant comic book aesthetics",
	"cel-shaded rendering with halftone patterns, dramatic shadows and action emphasis lines",
	"sharp high-contrast visuals with crisp panel-like composition and punchy color schemes"
)

static var HAND_DRAWN_2D := GameStyle.new(
	Id.HAND_DRAWN_2D,
	"Hand-Drawn 2D",
	"Traditional art style digitized or created to appear hand-crafted, featuring visible brushstrokes, organic lines, and artistic imperfections.",
	["Hollow Knight", "Cuphead", "Gris", "Child of Light", "Ori and the Will of the Wisps"],
	"traditional hand-drawn animation with expressive brushstrokes and artistic flourishes",
	"frame-by-frame animation with natural media simulation and organic line variation",
	"high-resolution brush detail with authentic traditional art qualities and fluid motion"
)

static var LOW_POLY := GameStyle.new(
	Id.LOW_POLY,
	"Low Poly",
	"3D graphics using minimal polygon counts, creating a distinct geometric aesthetic with flat or simple shading and clean lines.",
	["Superhot", "Firewatch", "Ashen", "Grow Home", "A Short Hike"],
	"minimalist geometric style with clean faceted surfaces and striking angular forms",
	"flat shading with sharp edges, simple texturing and bold geometric patterns",
	"precise polygon definition with crisp edges and clean geometric aesthetic"
)

static var MINIMALIST := GameStyle.new(
	Id.MINIMALIST,
	"Minimalist",
	"Stark, simplified visuals using basic geometric shapes, limited color palettes, and essential elements only.",
	["Thomas Was Alone", "N++", "Mini Metro", "Superhot", "Monument Valley"],
	"pure geometric forms with essential shapes and carefully selected colors",
	"clean vector-like rendering with precise edges and purposeful negative space",
	"perfect geometric clarity with pure color reproduction and sharp minimal detail"
)

static var PIXEL_ART := GameStyle.new(
	Id.PIXEL_ART,
	"Pixel Art",
	"Digital art where images are created using small colored squares (pixels), emphasizing precise pixel-by-pixel control and limited color palettes.",
	["Stardew Valley", "Hyper Light Drifter", "Celeste", "Dead Cells", "Terraria"],
	"classic pixel-based graphics with carefully crafted sprites and authentic retro aesthetic",
	"pixel-perfect rendering with intentional aliasing and precise dithering patterns",
	"clean pixel definition with sharp edges and carefully selected color palettes"
)

static var REALISTIC_3D := GameStyle.new(
	Id.REALISTIC_3D,
	"Realistic 3D",
	"High-fidelity 3D graphics aiming for photorealism through detailed textures, complex lighting, and advanced rendering techniques.",
	["Red Dead Redemption 2", "The Last of Us Part II", "Cyberpunk 2077", "Death Stranding", "Microsoft Flight Simulator"],
	"photorealistic 3D graphics with detailed materials and natural lighting",
	"physically based rendering with global illumination, advanced shadows and atmospheric effects",
	"ultra-high resolution textures with complex material properties and microscopic surface detail"
)

static var RETRO := GameStyle.new(
	Id.RETRO,
	"Retro",
	"Visual style emulating classic gaming eras, incorporating scanlines, limited color palettes, and period-appropriate technical limitations.",
	["Shovel Knight", "Undertale", "CrossCode", "The Messenger", "Streets of Rage 4"],
	"classic gaming era aesthetics with authentic period-appropriate visuals and effects",
	"era-specific rendering with scanlines, color limitations and characteristic artifacts",
	"authentic retro resolution with precise pixel scaling and genuine classic feel"
)

static var STYLIZED_3D := GameStyle.new(
	Id.STYLIZED_3D,
	"Stylized 3D",
	"Non-photorealistic 3D graphics emphasizing artistic expression through exaggerated proportions, bold colors, and distinctive visual treatments.",
	["Overwatch", "Sea of Thieves", "The Legend of Zelda: Breath of the Wild", "Valorant", "Team Fortress 2"],
	"artistically enhanced 3D with stylized proportions and distinctive visual character",
	"non-photorealistic rendering with custom shading, bold colors and artistic effects",
	"high-quality stylization with consistent art direction and polished presentation"
)

static var VOXEL := GameStyle.new(
	Id.VOXEL,
	"Voxel",
	"3D graphics using cubic building blocks (voxels), creating distinctive blocky visuals with unique construction and destruction possibilities.",
	["Minecraft", "Trove", "Cube World", "Deep Rock Galactic", "Teardown"],
	"block-based 3D graphics with cubic geometry and distinctive voxel aesthetic",
	"voxel-based rendering with precise cubic alignment and block-level destruction",
	"clean block definition with sharp edges and consistent cubic structure"
)

static var WATERCOLOR := GameStyle.new(
	Id.WATERCOLOR,
	"Watercolor",
	"Digital recreation of watercolor painting techniques, featuring soft color blending, texture overlays, and organic paint effects.",
	["Child of Light", "Dordogne", "I Am Dead", "Lost Words: Beyond the Page", "The Unfinished Swan"],
	"digital watercolor style with gentle color blending and organic painted qualities",
	"watercolor simulation with natural pigment diffusion and paper grain interaction",
	"high-resolution paint detail with authentic media properties and subtle color variation"
)

# Static dictionary containing all styles
static var ALL_STYLES = [
	ANIME,
	CARTOON,
	CLAYMATION,
	COMIC_BOOK,
	HAND_DRAWN_2D,
	LOW_POLY,
	MINIMALIST,
	PIXEL_ART,
	REALISTIC_3D,
	RETRO,
	STYLIZED_3D,
	VOXEL,
	WATERCOLOR
]
