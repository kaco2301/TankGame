// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Internal_Flame"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_noise("noise", 2D) = "white" {}
		_GRA_Circle("GRA_Circle", 2D) = "white" {}
		_Color("Color", Vector) = (1,1,1,0)
		[HideInInspector] _texcoord2( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Off
		ZWrite Off
		Blend One One
		
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha noshadow 
		struct Input
		{
			half2 uv2_texcoord2;
			half2 uv_texcoord;
			float4 vertexColor : COLOR;
		};

		uniform sampler2D _noise;
		uniform half4 _noise_ST;
		uniform sampler2D _GRA_Circle;
		uniform half4 _GRA_Circle_ST;
		uniform half3 _Color;
		uniform float _Cutoff = 0.5;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv_noise = i.uv_texcoord * _noise_ST.xy + _noise_ST.zw;
			half4 tex2DNode1 = tex2D( _noise, uv_noise );
			float2 uv_GRA_Circle = i.uv_texcoord * _GRA_Circle_ST.xy + _GRA_Circle_ST.zw;
			float temp_output_8_0 = ( pow( ( tex2DNode1.g * 1.0 ) , 4.0 ) * tex2D( _GRA_Circle, uv_GRA_Circle ).r );
			o.Emission = ( half4( ( i.uv2_texcoord2.x * ( temp_output_8_0 * _Color ) ) , 0.0 ) * i.vertexColor ).rgb;
			o.Alpha = ( temp_output_8_0 * i.vertexColor.a );
			half ifLocalVar16 = 0;
			if( tex2DNode1.b >= i.uv2_texcoord2.y )
				ifLocalVar16 = 1.0;
			else
				ifLocalVar16 = 0.0;
			clip( ( ifLocalVar16 * i.vertexColor.a ) - _Cutoff );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
320;293;1906;1010;1641.826;646.4473;1.3;True;True
Node;AmplifyShaderEditor.SamplerNode;1;-1354,-229.5;Float;True;Property;_noise;noise;1;0;Create;True;0;0;False;0;db59ef4a51b3d754c894319f3efa6c69;db59ef4a51b3d754c894319f3efa6c69;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;3;-1207,-10.5;Float;False;Constant;_Float0;Float 0;1;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2;-1006,-196.5;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-966,45.5;Float;False;Constant;_Float1;Float 1;1;0;Create;True;0;0;False;0;4;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;5;-773,-189.5;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;7;-755,64.5;Float;True;Property;_GRA_Circle;GRA_Circle;2;0;Create;True;0;0;False;0;e3fd2c569ce51994b8081d853a55dfba;e3fd2c569ce51994b8081d853a55dfba;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;-424,-120.5;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;10;-382,173.5;Float;False;Property;_Color;Color;3;0;Create;True;0;0;False;0;1,1,1;10,4,2;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.TexCoordVertexDataNode;15;-227.8,-259.6;Float;False;1;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;18;-100.0277,-424.1467;Float;False;Constant;_Float3;Float 3;4;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;17;-115.6277,-520.3467;Float;False;Constant;_Float2;Float 2;4;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-148,-60.5;Float;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ConditionalIfNode;16;208.8168,-474.7241;Float;False;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;14;133,-166.5;Float;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.VertexColorNode;11;-158,164.5;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;13;264,198.5;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;19;487.5724,-353.9466;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;352.2,-36.59999;Float;False;2;2;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;824.2446,-2.235217;Half;False;True;2;Half;ASEMaterialInspector;0;0;Unlit;Internal_Flame;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Transparent;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;4;1;False;-1;1;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;2;0;1;2
WireConnection;2;1;3;0
WireConnection;5;0;2;0
WireConnection;5;1;6;0
WireConnection;8;0;5;0
WireConnection;8;1;7;1
WireConnection;9;0;8;0
WireConnection;9;1;10;0
WireConnection;16;0;1;3
WireConnection;16;1;15;2
WireConnection;16;2;17;0
WireConnection;16;3;17;0
WireConnection;16;4;18;0
WireConnection;14;0;15;1
WireConnection;14;1;9;0
WireConnection;13;0;8;0
WireConnection;13;1;11;4
WireConnection;19;0;16;0
WireConnection;19;1;11;4
WireConnection;12;0;14;0
WireConnection;12;1;11;0
WireConnection;0;2;12;0
WireConnection;0;9;13;0
WireConnection;0;10;19;0
ASEEND*/
//CHKSM=C6EBDF7B0F935682C6525577E9DFC663C72CD7D0