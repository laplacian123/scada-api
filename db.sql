DROP DATABASE SCADA;
GO

CREATE DATABASE SCADA;
GO

USE [SCADA];
GO


CREATE TABLE [PARTITION] (
  [partition_id] int PRIMARY KEY IDENTITY(1, 1),
  [name] nvarchar(255) UNIQUE NOT NULL
)
GO

CREATE TABLE [POINT] (
  [point_id] int PRIMARY KEY IDENTITY(1, 1),
  [name] nvarchar(255) UNIQUE NOT NULL,
  [partition_id] int NOT NULL,
  [type] nvarchar(5) NOT NULL CHECK ([type] IN ('AI', 'DI', 'DO', 'SDI'))
)
GO

CREATE TABLE [ELEMENT] (
  [elem_id] int PRIMARY KEY IDENTITY(1, 1),
  [name] nvarchar(255) UNIQUE NOT NULL,
  [point_id] int NOT NULL
)
GO

CREATE TABLE [AI_LIST] (
  [ai_id] int PRIMARY KEY IDENTITY(1, 1),
  [name] nvarchar(255) UNIQUE NOT NULL,
  [point_id] int NOT NULL,
  [data_type] nvarchar(100) NOT NULL,
  [scailing] float NOT NULL DEFAULT (1.0),
  [precision] tinyint NOT NULL DEFAULT (2),
  [min] float,
  [max] float
)
GO

CREATE TABLE [DI_LIST] (
  [di_id] int PRIMARY KEY IDENTITY(1, 1),
  [name] nvarchar(255) UNIQUE NOT NULL,
  [point_id] int NOT NULL,
  [point_num] tinyint NOT NULL
)
GO

CREATE TABLE [DO_LIST] (
  [do_id] int PRIMARY KEY IDENTITY(1, 1),
  [name] nvarchar(255) UNIQUE NOT NULL,
  [point_id] int NOT NULL,
  [tag_name] nvarchar(255) NOT NULL,
  [di_id] int NOT NULL
)
GO

CREATE TABLE [FUNCTION] (
  [function_id] int PRIMARY KEY IDENTITY(1, 1),
  [name] nvarchar(255) NOT NULL,
  [formula] nvarchar(4000) NOT NULL
)
GO

CREATE TABLE [SDI_LIST] (
  [sdi_id] int PRIMARY KEY IDENTITY(1, 1),
  [name] nvarchar(255) UNIQUE NOT NULL,
  [point_id] int NOT NULL,
  [function_id] int NOT NULL
)
GO

CREATE TABLE [VIEW] (
  [view_id] int PRIMARY KEY IDENTITY(1, 1),
  [name] nvarchar(255) UNIQUE NOT NULL
)
GO

CREATE TABLE [POPUP_WINDOW] (
  [popup_window_id] int PRIMARY KEY IDENTITY(1, 1),
  [name] nvarchar(255) NOT NULL
)
GO

CREATE TABLE [POPUP_POINTS] (
  [popup_window_id] int NOT NULL,
  [column] int NOT NULL,
  [order] int NOT NULL,
  [point_id] int NOT NULL,
  PRIMARY KEY ([popup_window_id], [column], [order])
)
GO

CREATE TABLE [SHAPE] (
  [shape_id] int PRIMARY KEY IDENTITY(1, 1),
  [name] nvarchar(255),
  [shape_type] tinyint NOT NULL CHECK (shape_type >= 0),
  [x] int NOT NULL CHECK (x >= 0),
  [y] int NOT NULL CHECK (y >= 0),
  [zoom] int NOT NULL DEFAULT (100),
  [is_button] bit NOT NULL DEFAULT (0),
  [is_popup] bit NOT NULL DEFAULT (0),
  [button_link] nvarchar(1000),
  [is_shine] bit NOT NULL DEFAULT (0),
  [tooltips] nvarchar(100)
)
GO


CREATE TABLE [RECTANGLE] (
  [shape_id] int PRIMARY KEY,
  [width] int NOT NULL CHECK (width >= 0),
  [height] int NOT NULL CHECK (height >= 0),
  [fill_color] nvarchar(7) DEFAULT 'FFFFFF' NOT NULL,
  [fill_style] int DEFAULT (0) NOT NULL,
  [border_color] nvarchar(7) DEFAULT '000000' NOT NULL,
  [border_width] int NOT NULL DEFAULT (1) CHECK (border_width >= 0),
  [border_style] int NOT NULL DEFAULT (0)
)
GO

CREATE TABLE [CIRCLE] (
  [shape_id] int PRIMARY KEY,
  [radius] int NOT NULL CHECK (radius >= 0),
  [fill_color] nvarchar(7) NOT NULL DEFAULT 'ffffff',
  [fill_style] int NOT NULL DEFAULT (0),
  [border_color] nvarchar(7) NOT NULL DEFAULT '000000',
  [border_width] int NOT NULL DEFAULT (1) CHECK (border_width >= 0),
  [border_style] int NOT NULL DEFAULT (0) 
)
GO

CREATE TABLE [ELLIPSE] (
  [shape_id] int PRIMARY KEY,
  [width] int NOT NULL CHECK (width >= 0),
  [height] int NOT NULL CHECK (height >= 0),
  [fill_color] nvarchar(7) NOT NULL DEFAULT 'FFFFFF',
  [fill_style] int NOT NULL DEFAULT (0),
  [border_color] nvarchar(7) NOT NULL DEFAULT '000000',
  [border_width] int NOT NULL DEFAULT (1) CHECK (border_width >= 0),
  [border_style] int NOT NULL DEFAULT (0) 
)
GO

CREATE TABLE [ARC] (
  [shape_id] int PRIMARY KEY,
  [width] int NOT NULL CHECK (width >= 0),
  [height] int NOT NULL CHECK (height >= 0),
  [start_angle] int NOT NULL CHECK ((start_angle >= 0) AND (start_angle <= 360)),
  [end_angle] int NOT NULL CHECK ((end_angle >= 0) AND (end_angle <= 360)),
  [border_color] nvarchar(7) NOT NULL DEFAULT '000000',
  [border_width] int NOT NULL DEFAULT (1) CHECK (border_width > 0),
  [border_style] int NOT NULL DEFAULT (0)
)
GO

CREATE TABLE [LINE] (
  [shape_id] int PRIMARY KEY,
  [border_color] nvarchar(7) NOT NULL DEFAULT '000000',
  [border_width] int NOT NULL DEFAULT (1) CHECK (border_width > 0),
  [border_style] int NOT NULL DEFAULT (0)
)
GO

CREATE TABLE [LINE_POINTS] (
  [shape_id] int NOT NULL,
  [order] int NOT NULL,
  [x] int NOT NULL,
  [y] int NOT NULL,
  PRIMARY KEY ([shape_id], [order])
)
GO

CREATE TABLE [POLYGON] (
  [shape_id] int PRIMARY KEY,
  [fill_color] nvarchar(7) NOT NULL DEFAULT 'FFFFFF',
  [fill_style] tinyint NOT NULL DEFAULT (0),
  [border_color] nvarchar(7) NOT NULL DEFAULT '000000',
  [border_width] int NOT NULL DEFAULT (1) CHECK (border_width >= 0),
  [border_style] tinyint NOT NULL DEFAULT (0)
)
GO

CREATE TABLE [POLYGON_POINTS] (
  [shape_id] int NOT NULL,
  [order] int NOT NULL,
  [x] int NOT NULL,
  [y] int NOT NULL,
  PRIMARY KEY ([shape_id], [order])
)
GO

CREATE TABLE [TEXT] (
  [shape_id] int PRIMARY KEY,
  [width] int NOT NULL CHECK (width >= 0),
  [height] int NOT NULL CHECK (height >= 0),
  [color] nvarchar(7) NOT NULL DEFAULT '000000',
  [font_family] nvarchar(100) NOT NULL,
  [font_style] tinyint DEFAULT (0) NOT NULL,
  [font_size] int CHECK (font_size > 0) NOT NULL,
  [text] nvarchar(255) NOT NULL
)
GO

CREATE TABLE [IMG] (
  [shape_id] int PRIMARY KEY,
  [width] int NOT NULL CHECK (width >= 0),
  [height] int CHECK (height >= 0) NOT NULL,
  [path] nvarchar(1000) NOT NULL
)
GO

CREATE TABLE [VIEW_SHAPES] (
  [view_id] int NOT NULL,
  [order] int NOT NULL,
  [shape_id] int NOT NULL,
  PRIMARY KEY ([view_id], [order])
)
GO

CREATE TABLE [ELEMENT_SHAPES] (
  [elem_id] int NOT NULL,
  [status] int NOT NULL,
  [shape_id] int NOT NULL,
  PRIMARY KEY ([elem_id], [status])
)
GO

CREATE TABLE [SHAPE_GROUP] (
  [group_id] int PRIMARY KEY IDENTITY(1, 1)
)
GO

CREATE TABLE [SHAPE_GROUP_MEM] (
  [group_id] int NOT NULL,
  [shape_id] int NOT NULL,
  PRIMARY KEY ([group_id], [shape_id])
)
GO

CREATE TABLE [HMI_MX] (
  [hmi_mx_id] int PRIMARY KEY IDENTITY(1, 1),
  [type] nvarchar(3) NOT NULL CHECK ([type] IN ('MX', 'ST')),
  [tag_name] nvarchar(255) UNIQUE NOT NULL,
  [value] float NOT NULL,
  [time] timestamp NOT NULL,
  [quality] int NOT NULL
)
GO

CREATE TABLE [HMI_ST] (
  [hmi_mx_id] int PRIMARY KEY IDENTITY(1, 1),
  [type] nvarchar(3) NOT NULL CHECK ([type] IN ('MX', 'ST')),
  [tag_name] nvarchar(255) UNIQUE NOT NULL,
  [value] int NOT NULL,
  [time] timestamp NOT NULL,
  [quality] int NOT NULL
)
GO


CREATE TABLE [HMI_VIEW_ALARM] (
  [hmi_view_alarm_id] int PRIMARY KEY IDENTITY(1, 1),
  [type] nvarchar(255) NOT NULL,
  [tag_name] nvarchar(255) NOT NULL,
  [client] nvarchar(255) NOT NULL,
  [is_ack] bit NOT NULL DEFAULT (0)
)
GO

CREATE TABLE [BUTTON_TREE_NODES] (
  [node_id] int PRIMARY KEY IDENTITY(1, 1),
  [parent_node_id] int,
  [link] nvarchar(784)
)
GO

CREATE TABLE [BUTTON_TREE_CHILD] (
  [node_id] int NOT NULL,
  [child_id] int NOT NULL,
  PRIMARY KEY ([node_id], [child_id])
)
GO


ALTER TABLE [POPUP_POINTS] ADD FOREIGN KEY ([popup_window_id]) REFERENCES [POPUP_WINDOW] ([popup_window_id])
GO

ALTER TABLE [SHAPE_GROUP_MEM] ADD FOREIGN KEY ([group_id]) REFERENCES [SHAPE_GROUP] ([group_id])
GO

ALTER TABLE [SHAPE_GROUP_MEM] ADD FOREIGN KEY ([shape_id]) REFERENCES [SHAPE] ([shape_id])
GO

ALTER TABLE [POINT] ADD FOREIGN KEY ([partition_id]) REFERENCES [PARTITION] ([partition_id])
GO

ALTER TABLE [ELEMENT] ADD FOREIGN KEY ([point_id]) REFERENCES [POINT] ([point_id])
GO

ALTER TABLE [AI_LIST] ADD FOREIGN KEY ([point_id]) REFERENCES [POINT] ([point_id])
GO

ALTER TABLE [DI_LIST] ADD FOREIGN KEY ([point_id]) REFERENCES [POINT] ([point_id])
GO

ALTER TABLE [DO_LIST] ADD FOREIGN KEY ([point_id]) REFERENCES [POINT] ([point_id])
GO

ALTER TABLE [SDI_LIST] ADD FOREIGN KEY ([point_id]) REFERENCES [POINT] ([point_id])
GO

ALTER TABLE [SDI_LIST] ADD FOREIGN KEY ([function_id]) REFERENCES [FUNCTION] ([function_id])
GO

ALTER TABLE [POPUP_POINTS] ADD FOREIGN KEY ([point_id]) REFERENCES [POINT] ([point_id])
GO

ALTER TABLE [RECTANGLE] ADD FOREIGN KEY ([shape_id]) REFERENCES [SHAPE] ([shape_id])
GO

ALTER TABLE [CIRCLE] ADD FOREIGN KEY ([shape_id]) REFERENCES [SHAPE] ([shape_id])
GO

ALTER TABLE [ELLIPSE] ADD FOREIGN KEY ([shape_id]) REFERENCES [SHAPE] ([shape_id])
GO

ALTER TABLE [ARC] ADD FOREIGN KEY ([shape_id]) REFERENCES [SHAPE] ([shape_id])
GO

ALTER TABLE [LINE] ADD FOREIGN KEY ([shape_id]) REFERENCES [SHAPE] ([shape_id])
GO

ALTER TABLE [TEXT] ADD FOREIGN KEY ([shape_id]) REFERENCES [SHAPE] ([shape_id])
GO

ALTER TABLE [LINE_POINTS] ADD FOREIGN KEY ([shape_id]) REFERENCES [LINE] ([shape_id])
GO

ALTER TABLE [POLYGON] ADD FOREIGN KEY ([shape_id]) REFERENCES [SHAPE] ([shape_id])
GO

ALTER TABLE [POLYGON_POINTS] ADD FOREIGN KEY ([shape_id]) REFERENCES [LINE] ([shape_id])
GO

ALTER TABLE [IMG] ADD FOREIGN KEY ([shape_id]) REFERENCES [SHAPE] ([shape_id])
GO

ALTER TABLE [VIEW_SHAPES] ADD FOREIGN KEY ([view_id]) REFERENCES [VIEW] ([view_id])
GO

ALTER TABLE [VIEW_SHAPES] ADD FOREIGN KEY ([shape_id]) REFERENCES [SHAPE] ([shape_id])
GO

ALTER TABLE [ELEMENT_SHAPES] ADD FOREIGN KEY ([elem_id]) REFERENCES [ELEMENT] ([elem_id])
GO

ALTER TABLE [ELEMENT_SHAPES] ADD FOREIGN KEY ([shape_id]) REFERENCES [SHAPE] ([shape_id])
GO

ALTER TABLE [BUTTON_TREE_NODES] ADD FOREIGN KEY ([parent_node_id]) REFERENCES [BUTTON_TREE_NODES] ([node_id])
GO

ALTER TABLE [BUTTON_TREE_NODES] ADD FOREIGN KEY ([view_id]) REFERENCES [VIEW] ([view_id])
GO

ALTER TABLE [BUTTON_TREE_CHILD] ADD FOREIGN KEY ([node_id]) REFERENCES [BUTTON_TREE_NODES] ([node_id])
GO

ALTER TABLE [BUTTON_TREE_CHILD] ADD FOREIGN KEY ([child_id]) REFERENCES [BUTTON_TREE_NODES] ([node_id])
GO
