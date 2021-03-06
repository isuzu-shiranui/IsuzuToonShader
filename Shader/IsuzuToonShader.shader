// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "IsuzuToonShader/Normal"
{
	Properties
	{
		[Header(Metallic)]_Metallic("Metallic", Range( 0 , 1)) = 0
		_Smoothness("Smoothness", Range( 0 , 1)) = 0.5
		[NoScaleOffset][Header(Base Map)]_MainTexure("Main Texure", 2D) = "white" {}
		_BaseColor("Base Color", Color) = (1,1,1,0)
		[NoScaleOffset][Header(Shadow Settings)]_1stShadeMap("1st Shade Map", 2D) = "white" {}
		_1stShadeColor("1st Shade Color", Color) = (0.8018868,0.8018868,0.8018868,0)
		[NoScaleOffset]_2ndShadeMap("2nd Shade Map", 2D) = "white" {}
		_2ndShadeColor("2nd Shade Color", Color) = (0.4811321,0.4811321,0.4811321,0)
		[Header(Toon Shade Settings)]_BaseColorStep("Base Color Step", Range( 0 , 1)) = 0
		_BaseShadeSoftness("Base Shade Softness", Range( 0 , 1)) = 0
		_ShadeColorStep("Shade Color Step", Range( 0 , 1)) = 0
		_1st2ndShadeSoftness("1st2nd Shade Softness", Range( 0 , 1)) = 0
		[Normal][Header(Normal Map)]_Normal("Normal", 2D) = "bump" {}
		_NormalScale("Normal Scale", Range( 0 , 10)) = 1
		[Header(Rim Light Settings)][Toggle(_USERIM_ON)] _UseRim("Use Rim", Float) = 0
		[Header(Rim Light)]_RimColor("Rim Color", Color) = (1,1,1,0)
		_RimLightMask("RimLight Mask", 2D) = "white" {}
		_RimPower("Rim Power", Range( 0 , 1)) = 0
		_RimOffset("Rim Offset", Range( 0 , 1)) = 0
		_RimBias("Rim Bias", Range( 0 , 1)) = 0
		[Header(Subsurface)][Toggle(_USESUBSURFACE_ON)] _UseSubsurface("Use Subsurface", Float) = 0
		_SSSMap("SSS Map", 2D) = "white" {}
		_SSSMultiplier("SSS Multiplier", Float) = 1
		_SSSColor("SSS Color", Color) = (0,0,0,0)
		_SSSColorPower("SSS Color Power", Float) = 4
		_SSSScale("SSS Scale", Float) = 1
		_SSSPower("SSS Power", Float) = 1
		_ShadowStrength("Shadow Strength", Range( 0 , 1)) = 1
		_PointLightPunchthrough("Point Light Punchthrough", Range( 0 , 1)) = 0
		_SubsurfaceDistortion("Subsurface Distortion", Range( 0 , 1)) = 0.822
		[NoScaleOffset][Header(Matcap Settings)]_Matcap("Matcap", 2D) = "black" {}
		[NoScaleOffset]_MatcapMask("Matcap Mask", 2D) = "white" {}
		[NoScaleOffset][Header(Specular Map)]_SpecularMask("Specular Mask", 2D) = "white" {}
		_SpecularColor("Specular Color", Color) = (0,0,0,0)
		_SpecularSmoothness("Specular Smoothness", Range( 0.001 , 1)) = 0.001
		_SpecularStep("Specular Step", Range( 0 , 1)) = 0
		[NoScaleOffset][Header(Emmision Map)]_EmmissiveMask("Emmissive Mask", 2D) = "black" {}
		[HDR]_EmmisiveColor("Emmisive Color", Color) = (1,1,1,1)
		[Header(Light Settings)]_UnlitIntensity("Unlit Intensity", Range( 0.001 , 4)) = 1
		[NoScaleOffset][Header(Outline Settings)]_OutlineMask("Outline Mask", 2D) = "white" {}
		_OutlineColor("Outline Color", Color) = (0,0,0,0)
		_OutlineWidth("Outline Width", Float) = 0
		[IntRange][Header(Stencil Buffer)]_Reference("Reference", Range( 0 , 255)) = 0
		[IntRange]_ReadMask("Read Mask", Range( 0 , 255)) = 255
		[IntRange]_WriteMask("Write Mask", Range( 0 , 255)) = 255
		[Enum(UnityEngine.Rendering.CompareFunction)]_CompFront("Comp. Front", Int) = 8
		[Enum(UnityEngine.Rendering.StencilOp)]_PassFront("Pass Front", Int) = 0
		[Enum(UnityEngine.Rendering.StencilOp)]_FailFront("Fail Front", Int) = 0
		[Enum(UnityEngine.Rendering.StencilOp)]_ZFailFront("ZFail Front", Int) = 0
		[Enum(UnityEngine.Rendering.CompareFunction)]_CompBack("Comp. Back", Int) = 8
		[Enum(UnityEngine.Rendering.StencilOp)]_PassBack("Pass Back", Int) = 0
		[Enum(UnityEngine.Rendering.StencilOp)]_FailBack("Fail Back", Int) = 0
		[Enum(UnityEngine.Rendering.StencilOp)]_ZFailBack("ZFail Back", Int) = 0
		[Enum(UnityEngine.Rendering.BlendMode)][Header(Blend)]_BlendRGBSrc("Blend RGB Src", Float) = 5
		[Enum(UnityEngine.Rendering.BlendMode)]_BlendRGBDst("Blend RGB Dst", Float) = 10
		[Enum(UnityEngine.Rendering.BlendOp)]_BlendOpRGB("Blend Op RGB", Float) = 0
		[Enum(UnityEngine.Rendering.BlendMode)]_BlendAlphaSrc("Blend Alpha Src", Float) = 5
		[Enum(UnityEngine.Rendering.BlendMode)]_BlendAlphaDst("Blend Alpha Dst", Float) = 10
		[Enum(UnityEngine.Rendering.BlendOp)]_BlendOpAlpha("Blend Op Alpha", Float) = 0
		[Enum(UnityEngine.Rendering.CullMode)][Header(Rendering)]_CullMode("Cull Mode", Int) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ }
		Cull Front
		CGPROGRAM
		#pragma target 3.0
		#pragma surface outlineSurf Outline nofog  keepalpha noshadow noambient novertexlights nolightmap nodynlightmap nodirlightmap nometa noforwardadd vertex:outlineVertexDataFunc 
		void outlineVertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float2 uv_OutlineMask651 = v.texcoord;
			float4 tex2DNode651 = tex2Dlod( _OutlineMask, float4( uv_OutlineMask651, 0, 0.0) );
			float3 ase_vertexNormal = v.normal.xyz;
			float3 outlineVar = ( tex2DNode651.r * _OutlineWidth * 0.01 * ase_vertexNormal );
			v.vertex.xyz += outlineVar;
		}
		inline half4 LightingOutline( SurfaceOutput s, half3 lightDir, half atten ) { return half4 ( 0,0,0, s.Alpha); }
		void outlineSurf( Input i, inout SurfaceOutput o )
		{
			float2 uv_OutlineMask651 = i.uv_texcoord;
			float4 tex2DNode651 = tex2D( _OutlineMask, uv_OutlineMask651 );
			o.Emission = ( _OutlineColor * tex2DNode651 ).rgb;
		}
		ENDCG
		

		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull [_CullMode]
		Stencil
		{
			Ref [_Reference]
			ReadMask [_ReadMask]
			WriteMask [_WriteMask]
			CompFront [_CompFront]
			PassFront [_PassFront]
			FailFront [_FailFront]
			ZFailFront [_ZFailFront]
			CompBack [_CompBack]
			PassBack [_PassBack]
			FailBack [_FailBack]
			ZFailBack [_ZFailBack]
		}
		Blend One Zero , SrcAlpha OneMinusSrcAlpha
		
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "UnityCG.cginc"
		#include "UnityStandardUtils.cginc"
		#include "UnityShaderVariables.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		#pragma shader_feature _USERIM_ON
		#pragma shader_feature _USESUBSURFACE_ON
		#ifdef UNITY_PASS_SHADOWCASTER
			#undef INTERNAL_DATA
			#undef WorldReflectionVector
			#undef WorldNormalVector
			#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
			#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
			#define WorldNormalVector(data,normal) half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))
		#endif
		struct Input
		{
			float2 uv_texcoord;
			float3 worldPos;
			float3 worldRefl;
			INTERNAL_DATA
			float3 worldNormal;
			half ASEVFace : VFACE;
		};

		struct SurfaceOutputCustomLightingCustom
		{
			half3 Albedo;
			half3 Normal;
			half3 Emission;
			half Metallic;
			half Smoothness;
			half Occlusion;
			half Alpha;
			Input SurfInput;
			UnityGIInput GIData;
		};

		uniform int _CompFront;
		uniform int _CompBack;
		uniform float _BlendAlphaSrc;
		uniform int _PassFront;
		uniform float _BlendOpRGB;
		uniform int _ZFailBack;
		uniform float _BlendAlphaDst;
		uniform float _BlendRGBSrc;
		uniform int _PassBack;
		uniform float _ReadMask;
		uniform int _FailFront;
		uniform int _FailBack;
		uniform float _BlendRGBDst;
		uniform int _CullMode;
		uniform float _BlendOpAlpha;
		uniform int _ZFailFront;
		uniform float _WriteMask;
		uniform float _Reference;
		uniform sampler2D _EmmissiveMask;
		uniform float4 _EmmisiveColor;
		uniform sampler2D _SpecularMask;
		uniform float4 _SpecularColor;
		uniform float _NormalScale;
		uniform sampler2D _Normal;
		uniform float4 _Normal_ST;
		uniform float _SpecularStep;
		uniform float _SpecularSmoothness;
		uniform sampler2D _2ndShadeMap;
		uniform sampler2D _MainTexure;
		uniform float4 _2ndShadeColor;
		uniform float _UnlitIntensity;
		uniform sampler2D _1stShadeMap;
		uniform float4 _1stShadeColor;
		uniform float4 _BaseColor;
		uniform float _BaseColorStep;
		uniform float _BaseShadeSoftness;
		uniform float _ShadeColorStep;
		uniform float _1st2ndShadeSoftness;
		uniform float _Smoothness;
		uniform float _Metallic;
		uniform sampler2D _RimLightMask;
		uniform float4 _RimLightMask_ST;
		uniform float4 _RimColor;
		uniform float _RimBias;
		uniform float _RimOffset;
		uniform float _RimPower;
		uniform sampler2D _Matcap;
		uniform sampler2D _MatcapMask;
		uniform float4 _SSSColor;
		uniform sampler2D _SSSMap;
		uniform float4 _SSSMap_ST;
		uniform float _SubsurfaceDistortion;
		uniform float _SSSPower;
		uniform float _SSSScale;
		uniform float _SSSMultiplier;
		uniform float _ShadowStrength;
		uniform float _PointLightPunchthrough;
		uniform float _SSSColorPower;
		uniform sampler2D _OutlineMask;
		uniform float _OutlineWidth;
		uniform float4 _OutlineColor;


		float3 False13_g178( float3 Normal )
		{
			return ShadeSH9(half4(Normal, 1.0));
		}


		float3 False8_g178( float3 Normal )
		{
			return ShadeSH9(half4(Normal, 1.0));
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			v.vertex.xyz += 0;
		}

		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			#ifdef UNITY_PASS_FORWARDBASE
			float ase_lightAtten = data.atten;
			if( _LightColor0.a == 0)
			ase_lightAtten = 0;
			#else
			float3 ase_lightAttenRGB = gi.light.color / ( ( _LightColor0.rgb ) + 0.000001 );
			float ase_lightAtten = max( max( ase_lightAttenRGB.r, ase_lightAttenRGB.g ), ase_lightAttenRGB.b );
			#endif
			#if defined(HANDLE_SHADOWS_BLENDING_IN_GI)
			half bakedAtten = UnitySampleBakedOcclusion(data.lightmapUV.xy, data.worldPos);
			float zDist = dot(_WorldSpaceCameraPos - data.worldPos, UNITY_MATRIX_V[2].xyz);
			float fadeDist = UnityComputeShadowFadeDistance(data.worldPos, zDist);
			ase_lightAtten = UnityMixRealtimeAndBakedShadows(data.atten, bakedAtten, UnityComputeShadowFade(fadeDist));
			#endif
			float2 uv_SpecularMask19_g179 = i.uv_texcoord;
			float3 ase_worldPos = i.worldPos;
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aseld
			float3 ase_worldlightDir = 0;
			#else //aseld
			float3 ase_worldlightDir = Unity_SafeNormalize( UnityWorldSpaceLightDir( ase_worldPos ) );
			#endif //aseld
			float2 uv_Normal = i.uv_texcoord * _Normal_ST.xy + _Normal_ST.zw;
			float3 NromalMap314_g170 = UnpackScaleNormal( tex2D( _Normal, uv_Normal ), _NormalScale );
			float dotResult63_g179 = dot( ase_worldlightDir , normalize( WorldReflectionVector( i , NromalMap314_g170 ) ) );
			float2 uv_2ndShadeMap51_g170 = i.uv_texcoord;
			float2 uv_MainTexure73_g170 = i.uv_texcoord;
			float4 tex2DNode73_g170 = tex2D( _MainTexure, uv_MainTexure73_g170 );
			#if defined(LIGHTMAP_ON) && ( UNITY_VERSION < 560 || ( defined(LIGHTMAP_SHADOW_MIXING) && !defined(SHADOWS_SHADOWMASK) && defined(SHADOWS_SCREEN) ) )//aselc
			float4 ase_lightColor = 0;
			#else //aselc
			float4 ase_lightColor = _LightColor0;
			#endif //aselc
			float3 lerpResult6_g178 = lerp( ( ase_lightColor.rgb * ase_lightAtten ) , ase_lightColor.rgb , step( _WorldSpaceLightPos0.w , 0.0 ));
			float3 appendResult12_g178 = (float3(0.05 , 0.05 , 0.05));
			float3 Normal13_g178 = float3( 0,0,0 );
			float3 localFalse13_g178 = False13_g178( Normal13_g178 );
			float3 Normal8_g178 = float3(0,-1,0);
			float3 localFalse8_g178 = False8_g178( Normal8_g178 );
			float3 LightColor57_g170 = max( saturate( lerpResult6_g178 ) , saturate( max( ( appendResult12_g178 * _UnlitIntensity ) , ( _UnlitIntensity * max( localFalse13_g178 , localFalse8_g178 ) ) ) ) );
			float4 SecondShadeColor96_g170 = ( ( tex2D( _2ndShadeMap, uv_2ndShadeMap51_g170 ) * ( tex2DNode73_g170 * _2ndShadeColor ) ) * float4( LightColor57_g170 , 0.0 ) );
			float2 uv_1stShadeMap61_g170 = i.uv_texcoord;
			float4 FirstShadeColor91_g170 = ( ( tex2D( _1stShadeMap, uv_1stShadeMap61_g170 ) * ( tex2DNode73_g170 * _1stShadeColor ) ) * float4( LightColor57_g170 , 0.0 ) );
			float4 BaseColor102_g170 = ( ( _BaseColor * tex2DNode73_g170 ) * float4( LightColor57_g170 , 0.0 ) );
			float dotResult30_g171 = dot( (WorldNormalVector( i , NromalMap314_g170 )) , ase_worldlightDir );
			float clampResult26_g171 = clamp( (ase_lightAtten*0.5 + 0.5) , 0.0001 , 1.0 );
			float temp_output_14_0_g171 = saturate( ase_lightColor.a );
			float4 lerpResult20_g171 = lerp( FirstShadeColor91_g170 , BaseColor102_g170 , ( 1.0 - saturate( ( (1.0 + ((dotResult30_g171*0.5 + 0.5) - ( _BaseColorStep - _BaseShadeSoftness )) * (0.0 - 1.0) / (_BaseColorStep - ( _BaseColorStep - _BaseShadeSoftness ))) * clampResult26_g171 * temp_output_14_0_g171 ) ) ));
			float4 lerpResult19_g171 = lerp( SecondShadeColor96_g170 , lerpResult20_g171 , ( 1.0 - saturate( ( clampResult26_g171 * (1.0 + ((dotResult30_g171*0.5 + 0.5) - ( _ShadeColorStep - _1st2ndShadeSoftness )) * (0.0 - 1.0) / (_ShadeColorStep - ( _ShadeColorStep - _1st2ndShadeSoftness ))) * temp_output_14_0_g171 ) ) ));
			float4 FinalBaseColor137_g170 = lerpResult19_g171;
			float3 indirectNormal8_g173 = WorldNormalVector( i , NromalMap314_g170 );
			Unity_GlossyEnvironmentData g8_g173 = UnityGlossyEnvironmentSetup( _Smoothness, data.worldViewDir, indirectNormal8_g173, float3(0,0,0));
			float3 indirectSpecular8_g173 = UnityGI_IndirectSpecular( data, 1.0, indirectNormal8_g173, g8_g173 );
			float4 lerpResult434_g170 = lerp( FinalBaseColor137_g170 , ( FinalBaseColor137_g170 * float4( LightColor57_g170 , 0.0 ) * float4( indirectSpecular8_g173 , 0.0 ) ) , _Metallic);
			float4 Metallic431_g170 = lerpResult434_g170;
			float4 SpecularColor189_g170 = ( ( tex2D( _SpecularMask, uv_SpecularMask19_g179 ) * _SpecularColor * saturate( ( ( dotResult63_g179 + (-1.0 + (_SpecularStep - 0.0) * (1.0 - -1.0) / (1.0 - 0.0)) ) / _SpecularSmoothness ) ) ) + Metallic431_g170 );
			float4 temp_output_31_0_g174 = SpecularColor189_g170;
			float2 uv_RimLightMask = i.uv_texcoord * _RimLightMask_ST.xy + _RimLightMask_ST.zw;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float fresnelNdotV32_g174 = dot( normalize( (WorldNormalVector( i , NromalMap314_g170 )) ), ase_worldViewDir );
			float fresnelNode32_g174 = ( _RimBias + _RimOffset * pow( 1.0 - fresnelNdotV32_g174, _RimPower ) );
			#ifdef _USERIM_ON
				float4 staticSwitch2_g174 = ( temp_output_31_0_g174 + ( tex2D( _RimLightMask, uv_RimLightMask ) * _RimColor * fresnelNode32_g174 ) );
			#else
				float4 staticSwitch2_g174 = temp_output_31_0_g174;
			#endif
			float4 RimLight215_g170 = staticSwitch2_g174;
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float2 uv_MatcapMask6_g175 = i.uv_texcoord;
			float4 Matcap218_g170 = ( tex2D( _Matcap, ((BlendNormals( ( mul( UNITY_MATRIX_V, float4( ase_worldViewDir , 0.0 ) ).xyz * float3(-1,-1,1) ) , mul( UNITY_MATRIX_V, float4( ase_worldNormal , 0.0 ) ).xyz )).xy*0.5 + 0.5) ) * tex2D( _MatcapMask, uv_MatcapMask6_g175 ) * float4( LightColor57_g170 , 0.0 ) );
			float2 uv_SSSMap = i.uv_texcoord * _SSSMap_ST.xy + _SSSMap_ST.zw;
			float dotResult11_g172 = dot( ase_worldViewDir , -( ase_worldlightDir + ( ase_worldNormal * _SubsurfaceDistortion ) ) );
			float dotResult13_g172 = dot( pow( ( ( dotResult11_g172 * ( 1.0 - _WorldSpaceLightPos0.w ) ) + ( _WorldSpaceLightPos0.w * ase_lightAtten ) ) , _SSSPower ) , _SSSScale );
			float temp_output_18_0_g172 = saturate( ( tex2D( _SSSMap, uv_SSSMap ).r * dotResult13_g172 * _SSSMultiplier ) );
			float temp_output_32_0_g172 = ( ( temp_output_18_0_g172 * saturate( ( ase_lightAtten + ( 1.0 - _ShadowStrength ) ) ) * ( 1.0 - _WorldSpaceLightPos0.w ) ) + ( ase_lightAtten * temp_output_18_0_g172 * _WorldSpaceLightPos0.w * _PointLightPunchthrough ) );
			float4 lerpResult26_g172 = lerp( _SSSColor , ase_lightColor , saturate( pow( temp_output_32_0_g172 , _SSSColorPower ) ));
			float4 switchResult52_g172 = (((i.ASEVFace>0)?(saturate( ( lerpResult26_g172 * saturate( ase_lightColor.a ) * temp_output_32_0_g172 ) )):(float4( 0,0,0,0 ))));
			#ifdef _USESUBSURFACE_ON
				float4 staticSwitch45_g172 = switchResult52_g172;
			#else
				float4 staticSwitch45_g172 = float4( 0,0,0,0 );
			#endif
			float4 SSS211_g170 = staticSwitch45_g172;
			c.rgb = saturate( ( RimLight215_g170 + Matcap218_g170 + SSS211_g170 ) ).xyz;
			c.a = 1;
			return c;
		}

		inline void LightingStandardCustomLighting_GI( inout SurfaceOutputCustomLightingCustom s, UnityGIInput data, inout UnityGI gi )
		{
			s.GIData = data;
		}

		void surf( Input i , inout SurfaceOutputCustomLightingCustom o )
		{
			o.SurfInput = i;
			o.Normal = float3(0,0,1);
			float2 uv_EmmissiveMask2_g176 = i.uv_texcoord;
			o.Emission = ( tex2D( _EmmissiveMask, uv_EmmissiveMask2_g176 ) * _EmmisiveColor ).rgb;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf StandardCustomLighting keepalpha fullforwardshadows exclude_path:deferred vertex:vertexDataFunc 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float4 tSpace0 : TEXCOORD2;
				float4 tSpace1 : TEXCOORD3;
				float4 tSpace2 : TEXCOORD4;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				vertexDataFunc( v, customInputData );
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				half3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				half3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = float3( IN.tSpace0.z, IN.tSpace1.z, IN.tSpace2.z );
				surfIN.worldRefl = -worldViewDir;
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				SurfaceOutputCustomLightingCustom o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputCustomLightingCustom, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "Shiranui_Isuzu.IsuzuToonShader.Inspector.IsuzuToonShaderInspector"
}
/*ASEBEGIN
Version=17400
24;68;1906;448;-1968.001;-474.7551;1;True;True
Node;AmplifyShaderEditor.ColorNode;649;1657.37,797.6154;Float;False;Property;_OutlineColor;Outline Color;53;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;650;1850.987,799.7914;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;579;1876.411,1574.261;Inherit;False;1221.773;942.1113;Comment;8;597;595;593;589;588;585;581;580;Master Node Output Options;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;651;1702.507,999.9757;Inherit;True;Property;_OutlineMask;Outline Mask;52;1;[NoScaleOffset];Create;True;0;0;False;1;Header(Outline Settings);-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;653;1998.795,1115.455;Float;False;Property;_OutlineWidth;Outline Width;54;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.NormalVertexDataNode;655;2089.068,1302.417;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;652;2143.487,799.7914;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;654;2106.342,1225.125;Float;False;Constant;_Float2;Float 2;5;0;Create;True;0;0;False;0;0.01;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;656;2527.188,869.8584;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;657;2304.376,1026.272;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;580;2184.898,1792.085;Inherit;False;408.8691;641.6335;Comment;11;599;598;596;594;592;591;590;587;586;584;583;Stencil Buffer;0.0147059,1,0.9184586,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;581;1924.315,1716.167;Inherit;False;232;165;Comment;1;582;Cull Mode;0.1172414,1,0,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;595;2861.992,2034.213;Float;False;Property;_BlendOpAlpha;Blend Op Alpha;71;1;[Enum];Create;True;0;1;UnityEngine.Rendering.BlendOp;True;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OutlineNode;658;2693.62,900.0198;Inherit;False;2;True;None;0;0;Front;3;0;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;588;2853.283,1849.583;Float;False;Property;_BlendAlphaSrc;Blend Alpha Src;69;1;[Enum];Create;True;0;1;UnityEngine.Rendering.BlendMode;True;0;5;5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;592;2204.134,1832.296;Float;False;Property;_Reference;Reference;55;1;[IntRange];Create;True;0;0;True;1;Header(Stencil Buffer);0;0;0;255;0;1;FLOAT;0
Node;AmplifyShaderEditor.IntNode;596;2204.134,2152.297;Float;False;Property;_PassFront;Pass Front;59;1;[Enum];Create;True;0;1;UnityEngine.Rendering.StencilOp;True;0;0;0;0;1;INT;0
Node;AmplifyShaderEditor.RangedFloatNode;598;2204.134,1992.296;Float;False;Property;_WriteMask;Write Mask;57;1;[IntRange];Create;True;0;0;True;0;255;255;0;255;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;720;2629.606,612.4785;Inherit;False;ShadeCore;0;;170;1d86b0e5f2bb83646b4b93539489b28b;0;0;5;COLOR;331;FLOAT;325;FLOAT;323;FLOAT4;0;COLOR;246
Node;AmplifyShaderEditor.RangedFloatNode;597;2649.901,2032.388;Float;False;Property;_BlendOpRGB;Blend Op RGB;68;1;[Enum];Create;True;0;1;UnityEngine.Rendering.BlendOp;True;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;599;2204.134,1912.296;Float;False;Property;_ReadMask;Read Mask;56;1;[IntRange];Create;True;0;0;True;0;255;255;0;255;0;1;FLOAT;0
Node;AmplifyShaderEditor.IntNode;590;2412.134,2152.297;Float;False;Property;_PassBack;Pass Back;63;1;[Enum];Create;True;0;1;UnityEngine.Rendering.StencilOp;True;0;0;0;0;1;INT;0
Node;AmplifyShaderEditor.RangedFloatNode;593;2648.338,1931.546;Float;False;Property;_BlendRGBDst;Blend RGB Dst;67;1;[Enum];Create;True;0;1;UnityEngine.Rendering.BlendMode;True;0;10;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.IntNode;591;2204.134,2072.296;Float;False;Property;_CompFront;Comp. Front;58;1;[Enum];Create;True;0;1;UnityEngine.Rendering.CompareFunction;True;0;8;8;0;1;INT;0
Node;AmplifyShaderEditor.IntNode;594;2412.134,2312.297;Float;False;Property;_ZFailBack;ZFail Back;65;1;[Enum];Create;True;1;Option1;0;1;UnityEngine.Rendering.StencilOp;True;0;0;0;0;1;INT;0
Node;AmplifyShaderEditor.IntNode;586;2412.134,2072.296;Float;False;Property;_CompBack;Comp. Back;62;1;[Enum];Create;True;0;1;UnityEngine.Rendering.CompareFunction;True;0;8;8;0;1;INT;0
Node;AmplifyShaderEditor.RangedFloatNode;585;2651.192,1848.759;Float;False;Property;_BlendRGBSrc;Blend RGB Src;66;1;[Enum];Create;True;0;1;UnityEngine.Rendering.BlendMode;True;1;Header(Blend);5;5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.IntNode;584;2412.134,2232.298;Float;False;Property;_FailBack;Fail Back;64;1;[Enum];Create;True;1;Option1;0;1;UnityEngine.Rendering.StencilOp;True;0;0;0;0;1;INT;0
Node;AmplifyShaderEditor.IntNode;583;2204.134,2232.298;Float;False;Property;_FailFront;Fail Front;60;1;[Enum];Create;True;1;Option1;0;1;UnityEngine.Rendering.StencilOp;True;0;0;0;0;1;INT;0
Node;AmplifyShaderEditor.IntNode;587;2204.134,2312.297;Float;False;Property;_ZFailFront;ZFail Front;61;1;[Enum];Create;True;1;Option1;0;1;UnityEngine.Rendering.StencilOp;True;0;0;0;0;1;INT;0
Node;AmplifyShaderEditor.IntNode;582;1968.75,1766.067;Float;False;Property;_CullMode;Cull Mode;72;1;[Enum];Create;True;0;1;UnityEngine.Rendering.CullMode;True;1;Header(Rendering);0;0;0;1;INT;0
Node;AmplifyShaderEditor.RangedFloatNode;589;2857.429,1937.37;Float;False;Property;_BlendAlphaDst;Blend Alpha Dst;70;1;[Enum];Create;True;0;1;UnityEngine.Rendering.BlendMode;True;0;10;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;2914.769,523.5805;Float;False;True;-1;2;Shiranui_Isuzu.IsuzuToonShader.Inspector.IsuzuToonShaderInspector;0;0;CustomLighting;IsuzuToonShader/Normal;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;ForwardOnly;14;all;True;True;True;True;0;False;-1;True;0;True;592;255;True;599;255;True;598;0;True;591;0;True;596;0;True;583;0;True;587;0;True;586;0;True;590;0;True;584;0;True;594;False;2;15;10;25;False;0.5;True;0;5;False;585;10;False;593;2;5;False;588;10;False;589;0;False;-1;0;False;595;0;False;0;0,0,0,0;VertexScale;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;True;582;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;650;0;649;0
WireConnection;652;0;650;0
WireConnection;656;0;652;0
WireConnection;656;1;651;0
WireConnection;657;0;651;1
WireConnection;657;1;653;0
WireConnection;657;2;654;0
WireConnection;657;3;655;0
WireConnection;658;0;656;0
WireConnection;658;1;657;0
WireConnection;0;2;720;331
WireConnection;0;13;720;0
WireConnection;0;11;658;0
ASEEND*/
//CHKSM=9D44B02BBD4662226FCF0FFED36E8DDFFD5EE1EC